import 'dart:io';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedSurahsAudioController extends GetxController {
  final audioPlayer = AudioPlayer();
  var currentSurahName = ''.obs;
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var downloadedSurahs = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDownloadedSurahs();
    _setupAudioPlayerListeners();
  }

  Future<void> _loadDownloadedSurahs() async {
    final appDir = await getApplicationDocumentsDirectory();
    final surahDir = Directory('${appDir.path}/downloaded_surahs');
    if (await surahDir.exists()) {
      downloadedSurahs.value = surahDir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.mp3'))
          .toList();
      downloadedSurahs.sort((a, b) => _extractSurahNumber(a.path).compareTo(_extractSurahNumber(b.path)));
    }
  }

  int _extractSurahNumber(String filePath) {
    final fileName = filePath.split('/').last;
    final numberPart = fileName.split('.').first;
    return int.tryParse(numberPart) ?? 0;
  }

  void _setupAudioPlayerListeners() {
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
      }
    });
  }

  Future<void> playSurah(File surahFile) async {
    currentSurahName.value = surahFile.path.split('/').last.split('.').first;
    await audioPlayer.setFilePath(surahFile.path);
    audioPlayer.play();
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}