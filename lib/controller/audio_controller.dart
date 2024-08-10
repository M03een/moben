import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/utils/helper.dart';

class AudioController extends GetxController {
  var isPlay = false.obs;
  var isMakkia = false.obs;
  var surahIndex = 0.obs;
  var readerName = ''.obs;
  var duration = const Duration().obs;
  var position = const Duration().obs;
  var loading = false.obs;
  var repeatSurah = false.obs;
  var shuffle = false.obs;
  var repeatAll = false.obs;

  AudioPlayer audioPlayer = AudioPlayer();
  final ReaderController readerController = Get.put(ReaderController());

  @override
  void onInit() {
    super.onInit();

    ever(readerController.readerIndex, (int newIndex) {
      readerName.value = HelperFunctions().readerUrl(id: newIndex);
      if (isPlay.value) {
        playOrPause(readerId: newIndex, surahId: surahIndex.value);
      }
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
      duration.value = d;
      loading.value = false;
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      position.value = p;
    });

    // Listen for when the audio finishes playing
    audioPlayer.onPlayerComplete.listen((event) {
      if (repeatSurah.value) {
        // Repeat the current Surah
        playOrPause(readerId: readerController.readerIndex.value, surahId: surahIndex.value);
      } else if (shuffle.value) {
        // Shuffle mode: Play a random Surah
        surahIndex.value = getRandomSurahIndex();
        playOrPause(readerId: readerController.readerIndex.value, surahId: surahIndex.value);
      } else if (repeatAll.value) {
        // Repeat all: Move to the next Surah, or go back to the first one if at the end
        next(surahId: surahIndex.value);
      }
    });
  }

  int getRandomSurahIndex() {
    Random random = Random(); // Create a Random instance
    return random.nextInt(114); // Generates a random integer between 0 (inclusive) and 114 (exclusive)
  }
  playOrPause({required int readerId, required int surahId}) async {
    isPlay.value = !isPlay.value;
    if (isPlay.value) {
      loading.value = true;
      await audioPlayer.play(UrlSource(
          '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3'));
    } else {
      await audioPlayer.pause();
    }
  }

  next({required int surahId}) async {
    if (surahIndex.value == 113) {
      if (repeatAll.value) {
        surahIndex.value = 0; // Go back to the first Surah
      } else {
        return;
      }
    } else {
      surahIndex++;
    }

    isPlay.value = true;
    await audioPlayer.stop();
    loading.value = true;
    await audioPlayer.play(UrlSource(
        '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3'));
  }

  previous({required int surahId}) async {
    if (surahIndex.value == 0) {
      return;
    } else {
      surahIndex--;
    }

    isPlay.value = true;
    await audioPlayer.stop();
    loading.value = true;
    await audioPlayer.play(UrlSource(
        '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3'));
  }
}
