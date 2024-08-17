import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/utils/helper.dart';

class AudioController extends GetxController {
  var isPlay = false.obs;
  var surahIndex = 0.obs;
  var readerName = ''.obs;
  var duration = const Duration().obs;
  var position = const Duration().obs;
  var loading = false.obs;
  var repeatSurah = false.obs;
  var shuffle = false.obs;
  var repeatAll = true.obs;
  var surahName = 'لايوحد سورة'.obs;


  AudioPlayer audioPlayer = AudioPlayer();
  final ReaderController readerController = Get.put(ReaderController());
  final SurahController surahController = Get.put(SurahController());



  @override
  void onInit() {
    super.onInit();
    ever(readerController.readerIndex, (int newIndex) {
      readerName.value = HelperFunctions().readerUrl(id: newIndex);
      if (isPlay.value) {
        onlyPlay(surahId: surahIndex.value + 1);
      }
    });

    audioPlayer.durationStream.listen((Duration? d) {
      if (d != null) {
        duration.value = d;
        loading.value = false;
      }
    });

    audioPlayer.positionStream.listen((Duration p) {
      position.value = p;
    });

    audioPlayer.playerStateStream.listen((playerState) {
      isPlay.value = playerState.playing;
      if (playerState.processingState == ProcessingState.completed) {
        if (repeatSurah.value) {
          onlyPlay(surahId: surahIndex.value + 1);
        } else if (shuffle.value) {
          surahIndex.value = getRandomSurahIndex();
          next(surahId: surahIndex.value);
        } else if (repeatAll.value) {
          next(surahId: surahIndex.value + 2);
        }
      }
    });
  }

  surahMediaItem({required int surahIndex}){
    return MediaItem(
      id: '$surahIndex',
      album: readerController.readerNames[readerController.readerIndex.value],
      title: surahController.surahs[surahIndex].name!,
      artUri: Uri.parse('https://img.freepik.com/premium-photo/islamic-background-with-empty-copy-space-good-special-event-like-ramadan-eid-al-fitr_800563-1650.jpg'),

    );
  }

  changeSurahIndex({required int newIndex}) async {
    surahIndex.value = newIndex;
    surahName.value = surahController.surahs[newIndex].name ?? 'Unknown Surah';
    isPlay.value = true;
    loading.value = true;
    await audioPlayer.setUrl(
      '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(newIndex + 1)}.mp3',
      tag: surahMediaItem(surahIndex: surahIndex.value),
    );
    await audioPlayer.play();
  }

  int getRandomSurahIndex() {
    Random random = Random();
    return random.nextInt(114);
  }

  playOrPause({required int readerId, required int surahId}) async {
    isPlay.value = !isPlay.value;
    if (isPlay.value) {
      surahName.value = surahController.surahs[surahIndex.value].name ?? 'Unknown Surah';
      await audioPlayer.play();
    } else {
      await audioPlayer.pause();
    }
  }

  onlyPlay({required int surahId}) async {
    surahName.value = surahController.surahs[surahId - 1].name ?? 'Unknown Surah';
    await audioPlayer.setUrl(
      '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3',
      tag: surahMediaItem(surahIndex: surahId - 1),
    );
    await audioPlayer.play();
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
    surahName.value = surahController.surahs[surahIndex.value].name ?? 'Unknown Surah';
    isPlay.value = true;
    loading.value = true;
    await audioPlayer.setUrl(
      '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3',
      tag: surahMediaItem(surahIndex: surahIndex.value),
    );
    await audioPlayer.play();
  }

  previous({required int surahId}) async {
    if (surahIndex.value == 0) {
      return;
    } else {
      surahIndex--;
    }
    surahName.value = surahController.surahs[surahIndex.value].name ?? 'Unknown Surah';
    isPlay.value = true;
    loading.value = true;
    await audioPlayer.setUrl(
      '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${HelperFunctions().converterId(surahId)}.mp3',
      tag: surahMediaItem(surahIndex: surahIndex.value),
    );
    await audioPlayer.play();
  }
}
