import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:moben/utils/surah_audio_id_generation.dart';

class AudioController extends GetxController {
  var isPlay = false.obs;
  var isMakkia = false.obs;
  var surahName = ''.obs;
  var surahIndex = 0.obs;
  var readerName = ''.obs;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    print('init $surahIndex');
    super.onInit();
  }

  playOrPause({required int readerId, required int surahId}) async {
    isPlay.value = !isPlay.value;
    if (isPlay.value) {
      await audioPlayer.play(UrlSource(
          'https://server11.mp3quran.net/yasser/${SurahAudioIdGeneration().converterId(surahId)}.mp3'));
    } else {
      await audioPlayer.pause();
    }
  }

  next({required int surahId}) async {
    if (surahIndex.value == 113) {
    } else {
      surahIndex++;
      isPlay.value = true;
    }


    await audioPlayer.stop();
    await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${SurahAudioIdGeneration().converterId(surahId)}.mp3'));

  }

  previous({required int surahId}) async {
    if (surahIndex.value == 0) {
    } else {
      surahIndex--;
      isPlay.value = true;
    }

    await audioPlayer.stop();

    await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${SurahAudioIdGeneration().converterId(surahId)}.mp3'));
  }

}
