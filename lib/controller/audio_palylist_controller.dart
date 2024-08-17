import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/utils/helper.dart';

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

  AudioPlayer audioPlayer = AudioPlayer();
  final ReaderController readerController = Get.put(ReaderController());
  final SurahController surahController = Get.put(SurahController());

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

    ever(surahController.surahs, (_) {
      if (surahController.surahs.isNotEmpty) {
        _initializePlaylist();
      }
    });
  }

  Future<void> changeSurahAndPlay(int newIndex) async {
    if (newIndex < 0 || newIndex >= 114) {
      print("Invalid surah index");
      return;
    }

    try {
      await audioPlayer.stop();
      surahIndex.value = newIndex-1;
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
        return 'Off';
      case LoopMode.all:
        return 'Repeat All';
      case LoopMode.one:
        return 'Repeat One';
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
      surahController.surahs.length,  // Make sure to use the actual length
          (index) {
        return AudioSource.uri(
          Uri.parse(
              '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${(index+1).toString().padLeft(3, '0')}.mp3'),
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

  void _updatePlaylist() async {
    int currentIndex = surahIndex.value;
    bool wasPlaying = isPlay.value;

    await audioPlayer.stop();

    ConcatenatingAudioSource newPlaylist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: _createAudioSources(),
    );

    await audioPlayer.setAudioSource(newPlaylist,
        initialIndex: currentIndex, initialPosition: Duration.zero);

    surahName.value =
        surahController.surahs[currentIndex].name ?? 'Unknown Surah';

    if (wasPlaying) {
      audioPlayer.play();
    }

    loading.value = false;
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
