import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/utils/helper.dart';

class AudioController extends GetxController {
  var isPlay = true.obs;
  var isMakkia = false.obs;
  var surahIndex = 0.obs;
  var readerName = ''.obs;
  var duration = const Duration().obs;
  var position = const Duration().obs;
  var loading = false.obs;
  var repeatSurah = false.obs;
  var shuffle = false.obs;
  var repeatAll = true.obs;

  AudioPlayer audioPlayer = AudioPlayer();
  final ReaderController readerController = Get.put(ReaderController());

  @override
  void onInit() {
    super.onInit();

    ever(readerController.readerIndex, (int newIndex) {
      readerName.value = HelperFunctions().readerUrl(id: newIndex);
      if (isPlay.value) {
        onlyPlay(surahId: surahIndex.value + 1);
      }
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
      duration.value = d;
      loading.value = false;
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      position.value = p;
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (repeatSurah.value) {
        onlyPlay(surahId: surahIndex.value + 1);
      } else if (shuffle.value) {
        surahIndex.value = getRandomSurahIndex();
        next(surahId: surahIndex.value);
      } else if (repeatAll.value) {
        next(surahId: surahIndex.value + 2);
      }
    });
  }

  changeSurahIndex({required int newIndex}) async {
    surahIndex = newIndex.obs;
    isPlay.value = true;
    await audioPlayer.stop();
    loading.value = true;
    await audioPlayer.play(UrlSource(
        '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(newIndex+1)}.mp3'));
  }

  int getRandomSurahIndex() {
    Random random = Random();
    return random.nextInt(114);
  }

  playOrPause({required int readerId, required int surahId}) async {
    isPlay.value = !isPlay.value;
    if (isPlay.value) {
      await audioPlayer.play(UrlSource(
          '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3'));
    } else {
      await audioPlayer.pause();
    }
  }

  onlyPlay({required int surahId}) async {
    await audioPlayer.play(UrlSource(
        '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3'));
  }

  next({required int surahId}) async {
    if (surahIndex.value == 113) {
      if (repeatAll.value) {
        surahIndex.value = 0;
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
