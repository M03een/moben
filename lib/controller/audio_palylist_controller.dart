import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/core/utils/helper.dart';

import '../core/global_audio_player.dart';

class AudioPlaylistController extends GetxController {
  var isPlay = false.obs;
  var surahIndex = 0.obs;
  var surahName = 'لايوجد سورة'.obs;
  var readerName = ''.obs;

  var duration = const Duration().obs;
  var position = const Duration().obs;
  var loading = false.obs;
  var isShuffle = false.obs;
  var repeatMode = LoopMode.off.obs;

  var isAudioDownloading = false.obs;
  var audioDownloadProgress = 0.0.obs;
  var audioDownloadStatus = 'download'.obs;

  var downloadedSurahsMap = <String, List<int>>{}.obs;
  var downloadedSurahName = 'init'.obs;
  var downloadedSurahs = <File>[].obs;
  var downloadedReaderName = ''.obs;
  var isDownloadedAudioPlaying = false.obs;
  var currentDownloadedPlayingIndex = (-1).obs;
  late ConcatenatingAudioSource _downloadedPlaylist;

  final AudioPlayer audioPlayer = GlobalAudioPlayer.instance;
  final ReaderController readerController = Get.put(ReaderController());
  final SurahController surahController = Get.put(SurahController());
  final Dio dio = Dio();

  late ConcatenatingAudioSource _playlist;

  @override
  void onInit() {
    audioPlayer.durationStream.listen((Duration? d) {
      if (d != null) {
        duration.value = d;
        loading.value = false;
      }
    });

    audioPlayer.positionStream.listen((Duration p) {
      position.value = p;
    });
    _initializePlaylist();
    _setupListeners();
    audioPlayer.setShuffleModeEnabled(false);
    audioPlayer.setLoopMode(LoopMode.off);

    ever(readerController.readerIndex, (_) => _handleReaderChange());

    ever(surahController.surahs, (_) {
      if (surahController.surahs.isNotEmpty) {
        _initializePlaylist();
      }
    });
    downloadedReaderName = readerController.downloadSelectedReader;
    _fetchDownloadedSurahs(readerName: downloadedReaderName.value);
    _initializeDownloadedPlaylist();
    audioPlayer.currentIndexStream.listen((index) {
      if (index != null && isDownloadedAudioPlaying.value) {
        _updateDownloadedSurahName(index);
      }
    });
    super.onInit();
  }

  Future<void> _fetchDownloadedSurahs({required String readerName}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String readerFolderPath = '${appDocDir.path}/$readerName';
    Directory readerFolder = Directory(readerFolderPath);

    if (await readerFolder.exists()) {
      List<File> files = readerFolder.listSync().whereType<File>().toList();

      files.sort((a, b) {
        int aNumber = _extractSurahNumber(a.path);
        int bNumber = _extractSurahNumber(b.path);
        return aNumber.compareTo(bNumber);
      });

      List<int> surahNumbers = files.map((file) {
        return _extractSurahNumber(file.path);
      }).toList();

      downloadedSurahs.value = files;
      downloadedSurahsMap[readerName] = surahNumbers;
    } else {
      downloadedSurahs.value = [];
      downloadedSurahsMap[readerName] = [];
    }
  }

  Future<void> refreshDownloadedSurahs({required String readerName}) async {
    await _fetchDownloadedSurahs(readerName: readerName);
    _initializeDownloadedPlaylist();
    update(); // Trigger UI update
  }

  int _extractSurahNumber(String filePath) {
    String fileName = filePath.split('/').last;
    String numberPart = fileName.split('.').first;
    return int.tryParse(numberPart) ?? 0;
  }

  Future<void> _initializeDownloadedPlaylist() async {
    await _fetchDownloadedSurahs(readerName: downloadedReaderName.value);
    if (downloadedSurahs.isNotEmpty) {
      _downloadedPlaylist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: _createDownloadedAudioSources(),
      );

      try {
        await audioPlayer.setAudioSource(_downloadedPlaylist);
        // Set the initial surah name
        _updateDownloadedSurahName(0);
      } catch (e) {
        print("Error setting downloaded audio source: $e");
        Get.snackbar('Error', 'Could not load downloaded audio sources',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  List<AudioSource> _createDownloadedAudioSources() {
    return downloadedSurahs.map((file) {
      final surahNumber = _extractSurahNumber(file.path);
      final surahName =
          surahController.surahs[surahNumber - 1].name ?? 'Unknown Surah';
      return AudioSource.uri(
        Uri.file(file.path),
        tag: MediaItem(
          id: file.path.split('/').last,
          album: downloadedReaderName.value,
          title: surahName,
          artUri: Uri.parse(
            'https://img.freepik.com/premium-photo/islamic-background-with-empty-copy-space-good-special-event-like-ramadan-eid-al-fitr_800563-1650.jpg',
          ),
        ),
      );
    }).toList();
  }

// check uses after debug
//   List<AudioSource> _createDownloadedAudioSources() {
//     return downloadedSurahs.map((file) {
//       final surahNumber = _extractSurahNumber(file.path); // Extract Surah number
//       downloadedSurahName = surahController.surahs[surahNumber - 1].name!.obs; // Fetch Surah name from controller
//       return AudioSource.uri(
//         Uri.file(file.path),
//         tag: MediaItem(
//           id: file.path.split('/').last,
//           album: downloadedReaderName.value,
//           title: downloadedSurahName.value, // Use the extracted Surah name here
//           artUri: Uri.parse(
//             'https://img.freepik.com/premium-photo/islamic-background-with-empty-copy-space-good-special-event-like-ramadan-eid-al-fitr_800563-1650.jpg',
//           ),
//         ),
//       );
//     }).toList();
//   }

  Future<void> downloadSurah(int surahIndex) async {
    isAudioDownloading.value = true;
    audioDownloadStatus.value = 'downloading';

    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String readerFolder =
          '${appDocDir.path}/${readerController.selectedReader.value}';
      await Directory(readerFolder).create(recursive: true);

      String surahUrl =
          '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${(surahIndex + 1).toString().padLeft(3, '0')}.mp3';
      String savePath =
          '$readerFolder/${(surahIndex + 1).toString().padLeft(3, '0')}.mp3';

      File file = File(savePath);
      if (await file.exists()) {
        MobenSnackBars().existSurahSnackBar();
        isAudioDownloading.value = false;
        audioDownloadStatus.value = 'downloaded';
        return;
      }

      await dio.download(
        surahUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            audioDownloadProgress.value = received / total;
          }
        },
      );

      audioDownloadStatus.value = 'downloaded';
      Get.snackbar('Success', 'Surah downloaded successfully',
          snackPosition: SnackPosition.BOTTOM);
      // refreshDownloadedSurahs(readerName: readerController.selectedReader.value);
    } catch (e) {
      print("Download failed: $e");
      Get.snackbar('Error', 'Download failed: $e',
          snackPosition: SnackPosition.BOTTOM);
      audioDownloadStatus.value = 'download';
    } finally {
      isAudioDownloading.value = false;
      audioDownloadStatus.value = 'download';
    }
  }

  void _handleReaderChange() async {
    int currentSurahIndex = surahIndex.value;
    await audioPlayer.stop();
    _initializePlaylist();
    surahIndex.value = currentSurahIndex;
    surahName.value =
        surahController.surahs[currentSurahIndex].name ?? 'Unknown Surah';
    await audioPlayer.seek(Duration.zero, index: currentSurahIndex);
    await audioPlayer.play();
    loading.value = true;
  }

  Future<void> changeSurahAndPlay(int newIndex) async {
    if (newIndex < 0 || newIndex >= 114) {
      print("Invalid surah index");
      return;
    }

    try {
      await audioPlayer.stop();
      surahIndex.value = newIndex - 1;
      surahName.value =
          surahController.surahs[newIndex].name ?? 'Unknown Surah';
      await audioPlayer.seek(Duration.zero, index: newIndex);
      await audioPlayer.play();
      loading.value = true;
    } catch (e) {
      print("Error changing surah: $e");
      loading.value = false;
    }
  }

  void toggleShuffle() {
    isShuffle.value = !isShuffle.value;
    audioPlayer.setShuffleModeEnabled(isShuffle.value);
  }

  void cycleRepeatMode() {
    switch (repeatMode.value) {
      case LoopMode.off:
        repeatMode.value = LoopMode.all;
        break;
      case LoopMode.all:
        repeatMode.value = LoopMode.one;
        break;
      case LoopMode.one:
        repeatMode.value = LoopMode.off;
        break;
    }
    audioPlayer.setLoopMode(repeatMode.value);
  }

  String get repeatModeString {
    switch (repeatMode.value) {
      case LoopMode.off:
        return 'التكرار مغلق';
      case LoopMode.all:
        return 'تكرار الكل';
      case LoopMode.one:
        return 'تكرار مرة واحدة';
    }
  }

  void _initializePlaylist() {
    if (surahController.surahs.isNotEmpty) {
      _playlist = ConcatenatingAudioSource(
          useLazyPreparation: true,
          shuffleOrder: DefaultShuffleOrder(),
          children: _createAudioSources());
      audioPlayer.setAudioSource(_playlist);
    } else {
      print("Surah list is empty. Cannot initialize playlist.");
    }
  }

  List<AudioSource> _createAudioSources() {
    return List.generate(
      surahController.surahs.length,
      (index) {
        return AudioSource.uri(
          Uri.parse(
              '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${(index + 1).toString().padLeft(3, '0')}.mp3'),
          tag: MediaItem(
            id: '${index + 1}',
            album: readerController.selectedReader.value,
            title: surahController.surahs[index].name ?? 'Unknown Surah',
            artUri: Uri.parse(
              'https://img.freepik.com/premium-photo/islamic-background-with-empty-copy-space-good-special-event-like-ramadan-eid-al-fitr_800563-1650.jpg',
            ),
          ),
        );
      },
    );
  }

  void _setupListeners() {
    audioPlayer.playerStateStream.listen((playerState) {
      isPlay.value = playerState.playing;
      if (playerState.processingState == ProcessingState.completed) {
        next();
      }
    });

    audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        surahIndex.value = index;
        surahName.value = surahController.surahs[index].name ?? 'Unknown Surah';
      }
    });
  }

  Future<void> play() async {
    print(
        '================================= Online play ================================= download index: $currentDownloadedPlayingIndex =main index= $surahIndex =surah name=$surahName');
    try {
      // Stop any currently playing audio
      await audioPlayer.stop();

      // Set the correct playlist (online)
      await audioPlayer.setAudioSource(_playlist);

      // Play the audio
      await audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> playTrack(int index) async {
    print(
        '================================= Online play Track ================================= download index: $currentDownloadedPlayingIndex =main index= $surahIndex =surah name=$surahName');

    if (index < 0 || index >= surahController.surahs.length) {
      print("Invalid surah index");
      return;
    }

    try {
      // Stop the current audio
      await audioPlayer.stop();

      // Update the index
      surahIndex.value = index;
      surahName.value = surahController.surahs[index].name ?? 'Unknown Surah';

      // Set the audio source to the online playlist
      await audioPlayer.setAudioSource(_playlist, initialIndex: index);

      // Play the audio
      await audioPlayer.play();
      loading.value = true;
    } catch (e) {
      print("Error changing surah: $e");
      loading.value = false;
    }
  }

  void pause() {
    print(
        '================================= Online pause ================================= download index: $currentDownloadedPlayingIndex =main index= $surahIndex =surah name=$surahName');

    audioPlayer.pause();
  }

  void stop() {
    print(
        '================================= Online stop ================================= download index: $currentDownloadedPlayingIndex =main index= $surahIndex =surah name=$surahName');
    audioPlayer.stop();
  }

  void next() {
    print(
        '================================= Online next ================================= download index: $currentDownloadedPlayingIndex =main index= $surahIndex =surah name=$surahName');

    audioPlayer.seekToNext();
  }

  void previous() {
    print(
        '================================= Online previous ================================= download index: $currentDownloadedPlayingIndex =main index= $surahIndex =surah name=$surahName');

    audioPlayer.seekToPrevious();
  }

  void _updateDownloadedSurahName(int index) {
    if (index >= 0 && index < downloadedSurahs.length) {
      final surahNumber = _extractSurahNumber(downloadedSurahs[index].path);
      downloadedSurahName.value = surahController.surahs[surahNumber - 1].name ?? 'Unknown Surah';
    }
  }

  Future<void> playDownloaded(int index) async {
    print('Playing downloaded audio: index=$index');
    if (index < 0 || index >= downloadedSurahs.length) return;

    try {
      await audioPlayer.setAudioSource(_downloadedPlaylist, initialIndex: index);
      await audioPlayer.play();
      currentDownloadedPlayingIndex.value = index;
      isDownloadedAudioPlaying.value = true;
      _updateDownloadedSurahName(index);
    } catch (e) {
      print("Error playing downloaded audio: $e");
      Get.snackbar('Error', 'Failed to play downloaded audio',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Update these methods to use _updateDownloadedSurahName
  Future<void> nextDownloaded() async {
    print('Playing next downloaded audio');
    if (currentDownloadedPlayingIndex.value < downloadedSurahs.length - 1) {
      await playDownloaded(currentDownloadedPlayingIndex.value + 1);
    } else if (repeatMode.value == LoopMode.all) {
      await playDownloaded(0);
    }
  }

  Future<void> previousDownloaded() async {
    print('Playing previous downloaded audio');
    if (currentDownloadedPlayingIndex.value > 0) {
      await playDownloaded(currentDownloadedPlayingIndex.value - 1);
    } else if (repeatMode.value == LoopMode.all) {
      await playDownloaded(downloadedSurahs.length - 1);
    }
  }
  // Future<void> playDownloaded(int index) async {
  //   print('Playing downloaded audio: index=$index');
  //   if (index < 0 || index >= downloadedSurahs.length) return;
  //
  //   try {
  //     await audioPlayer.setAudioSource(_downloadedPlaylist, initialIndex: index);
  //     await audioPlayer.play();
  //     currentDownloadedPlayingIndex.value = index;
  //     isDownloadedAudioPlaying.value = true;
  //   } catch (e) {
  //     print("Error playing downloaded audio: $e");
  //     Get.snackbar('Error', 'Failed to play downloaded audio',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  Future<void> pauseDownloaded() async {
    print('Pausing downloaded audio');
    await audioPlayer.pause();
    isDownloadedAudioPlaying.value = false;
  }

  Future<void> resumeDownloaded() async {
    print('Resuming downloaded audio');
    await audioPlayer.play();
    isDownloadedAudioPlaying.value = true;
  }

  Future<void> stopDownloaded() async {
    print('Stopping downloaded audio');
    await audioPlayer.stop();
    isDownloadedAudioPlaying.value = false;
    currentDownloadedPlayingIndex.value = -1;
  }

  Future<void> seekToDownloaded(Duration position) async {
    print('Seeking downloaded audio to: $position');
    await audioPlayer.seek(position);
  }

  // Future<void> nextDownloaded() async {
  //   print('Playing next downloaded audio');
  //   if (currentDownloadedPlayingIndex.value < downloadedSurahs.length - 1) {
  //     await playDownloaded(currentDownloadedPlayingIndex.value + 1);
  //   }
  // }
  //
  // Future<void> previousDownloaded() async {
  //   print('Playing previous downloaded audio');
  //   if (currentDownloadedPlayingIndex.value > 0) {
  //     await playDownloaded(currentDownloadedPlayingIndex.value - 1);
  //   }
  // }

  String getSurahName(String filePath) {
    String fileName = filePath.split('/').last;
    String numberPart = fileName.split('.').first;
    int surahNumber = int.tryParse(numberPart) ?? 0;

    if (surahNumber > 0 && surahNumber <= surahController.surahs.length) {
      return surahController.surahs[surahNumber - 1].name ?? 'Unknown Surah';
    }
    return 'Unknown Surah';
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
