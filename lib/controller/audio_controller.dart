import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:moben/utils/surah_audio_id_generation.dart';

class AudioController extends GetxController {
  var isPause = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
  }

  playOrPause({required int readerId, required int surahId}) async {
    isPause.value = !isPause.value;
    if (isPause.value) {
      print('==========================');
      print('play $surahId');
      print('==========================');
      await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${SurahAudioIdGeneration().converterId(surahId)}.mp3'));
    } else {
      await audioPlayer.pause();
    }
  }

  next({required int surahId})async{
    await audioPlayer.stop();
    surahId++;
    print('==========================');
    print('next $surahId');
    print('==========================');
    await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${SurahAudioIdGeneration().converterId(surahId)}.mp3'));

  }
  previous({required int surahId})async{
    await audioPlayer.stop();
    int newSurahId = surahId-1;
    print('==========================');
    print('previous $surahId');
    print('==========================');
    await audioPlayer.play(UrlSource(
        'https://server11.mp3quran.net/yasser/${SurahAudioIdGeneration().converterId(surahId)}.mp3'));

  }
}
