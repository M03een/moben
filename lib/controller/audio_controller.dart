import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:moben/utils/helper.dart';

class AudioController extends GetxController {
  var isPlay = false.obs;
  var isMakkia = false.obs;
  var surahIndex = 0.obs;
  var readerName = ''.obs;
  var duration = const Duration().obs;
  var position = const Duration().obs;
  var loading = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration.value = d;
      loading.value = false;
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      position.value = p;
    });
    super.onInit();
  }

  playOrPause({required int readerId, required int surahId}) async {
    isPlay.value = !isPlay.value;
    if (isPlay.value) {
      loading.value = true;
      await audioPlayer.play(UrlSource(
          'https://server11.mp3quran.net/yasser/${HelperFunctions().converterId(surahId)}.mp3'));
    } else {
      await audioPlayer.pause();
    }
  }

  next({required int surahId}) async {
    if (surahIndex.value == 113) {
      return;
    } else {
      surahIndex++;
      isPlay.value = true;
    }

    await audioPlayer.stop();
    loading.value = true;
    await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${HelperFunctions().converterId(surahId)}.mp3'));
  }

  previous({required int surahId}) async {
    if (surahIndex.value == 0) {
      return;
    } else {
      surahIndex--;
      isPlay.value = true;
    }

    await audioPlayer.stop();
    loading.value = true;
    await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${HelperFunctions().converterId(surahId)}.mp3'));
  }
}
