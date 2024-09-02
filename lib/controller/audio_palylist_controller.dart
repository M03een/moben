import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/core/utils/helper.dart';

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

  var isDownloading = false.obs;
  var downloadProgress = 0.0.obs;
  var downloadStatus =
      'download'.obs;

  AudioPlayer audioPlayer = AudioPlayer();
  final ReaderController readerController = Get.put(ReaderController());
  final SurahController surahController = Get.put(SurahController());
  final Dio dio = Dio();

  late ConcatenatingAudioSource _playlist;

  @override
  void onInit() {
    super.onInit();

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
  }

  Future<void> downloadSurah(int surahIndex) async {
    isDownloading.value = true;
    downloadStatus.value = 'downloading';

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
        isDownloading.value = false;
        downloadStatus.value = 'downloaded';
        return;
      }

      await dio.download(
        surahUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = received / total;
          }
        },
      );

      downloadStatus.value = 'downloaded';
      Get.snackbar('Success', 'Surah downloaded successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("Download failed: $e");
      Get.snackbar('Error', 'Download failed: $e',
          snackPosition: SnackPosition.BOTTOM);
      downloadStatus.value = 'download';
    } finally {
      isDownloading.value = false;
      downloadStatus.value = 'download';
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
    try {
      if (audioPlayer.playing) {
        await audioPlayer.play();
      } else {
        await audioPlayer.play();
      }
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> playTrack(int index) async {
    try {
      await audioPlayer.seek(Duration.zero, index: index);
      await audioPlayer.play();
    } catch (e) {
      print("Error playing specific track: $e");
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    audioPlayer.stop();
  }

  void next() {
    audioPlayer.seekToNext();
  }

  void previous() {
    audioPlayer.seekToPrevious();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
