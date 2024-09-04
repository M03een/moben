import 'dart:io';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedSurahsController extends GetxController {
  final ReaderController readerController = Get.put(ReaderController());
  var downloadedSurahs = <File>[].obs;
  var readerName = ''.obs;

  // Create a separate AudioPlayer instance
  final AudioPlayer audioPlayer = AudioPlayer();

  var isPlaying = false.obs;
  var currentPlayingIndex = (-1).obs;
  late ConcatenatingAudioSource _playlist; // Playlist to manage multiple audio sources

  @override
  void onInit() {
    readerName = readerController.downloadSelectedReader;
    _fetchDownloadedSurahs(readerName: readerName.value);
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

      downloadedSurahs.value = files;
      _initializePlaylist(); // Initialize the playlist with the downloaded Surahs
    }
  }

  int _extractSurahNumber(String filePath) {
    String fileName = filePath.split('/').last;
    String numberPart = fileName.split('.').first;
    return int.tryParse(numberPart) ?? 0;
  }

  void _initializePlaylist() async {
    if (downloadedSurahs.isNotEmpty) {
      _playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: _createAudioSources(),
      );

      try {
        await audioPlayer.setAudioSource(_playlist);
      } catch (e) {
        print("Error setting audio source: $e");
        Get.snackbar('Error', 'Could not load audio sources', snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      print("No downloaded Surahs found. Cannot initialize playlist.");
    }
  }
  List<AudioSource> _createAudioSources() {
    return downloadedSurahs.map((file) {
      return AudioSource.uri(
        Uri.file(file.path),
        tag: MediaItem(
          id: file.path.split('/').last,
          album: readerController.downloadSelectedReader.value,
          title: _getSurahName(file.path),
          artUri: Uri.parse(
            'https://img.freepik.com/premium-photo/islamic-background-with-empty-copy-space-good-special-event-like-ramadan-eid-al-fitr_800563-1650.jpg',
          ),
        ),
      );
    }).toList();
  }

  String _getSurahName(String filePath) {
    String fileName = filePath.split('/').last;
    return fileName.replaceAll('.mp3', '').split('_').last;
  }

  Future<void> play(int index) async {
    if (index < 0 || index >= downloadedSurahs.length) return;

    if (currentPlayingIndex.value != index) {
      await audioPlayer.seek(Duration.zero, index: index);
      currentPlayingIndex.value = index;
    }

    await audioPlayer.play();
    isPlaying.value = true;
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  Future<void> resume() async {
    await audioPlayer.play();
    isPlaying.value = true;
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    isPlaying.value = false;
    currentPlayingIndex.value = -1;
  }

  Future<void> seekTo(Duration position) async {
    await audioPlayer.seek(position);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
