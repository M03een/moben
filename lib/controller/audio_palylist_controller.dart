// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:get/get.dart';
// import 'package:moben/controller/reader_controller.dart';
// import 'package:moben/controller/surah_controller.dart';
// import 'package:moben/utils/helper.dart';
//
//
// class AudioPlaylistController extends GetxController {
//   var isPlay = false.obs;
//   var surahIndex = 0.obs;
//   var surahName = 'لايوجد سورة'.obs;
//   var duration = const Duration().obs;
//   var position = const Duration().obs;
//   var loading = false.obs;
//
//   AudioPlayer audioPlayer = AudioPlayer();
//   final ReaderController readerController = Get.put(ReaderController());
//   final SurahController surahController = Get.put(SurahController());
//
//   late ConcatenatingAudioSource _playlist;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//
//     audioPlayer.durationStream.listen((Duration? d) {
//       if (d != null) {
//         duration.value = d;
//         loading.value = false;
//       }
//     });
//
//     audioPlayer.positionStream.listen((Duration p) {
//       position.value = p;
//     });
//     _initializePlaylist();
//     _setupListeners();
//   }
//
//   void _initializePlaylist() {
//     _playlist = ConcatenatingAudioSource(
//       useLazyPreparation: true,
//       shuffleOrder: DefaultShuffleOrder(),
//       children: List.generate(
//         114,
//             (index) {
//           return AudioSource.uri(
//             Uri.parse(
//                 '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${(index + 1).toString().padLeft(3, '0')}.mp3'),
//             tag: MediaItem(
//               id: '${index + 1}',
//               album: readerController.readerNames[readerController.readerIndex.value],
//               title: surahController.surahs[index].name ?? 'Unknown Surah',
//               artUri: Uri.parse(
//                   'https://img.freepik.com/premium-photo/islamic-background-with-empty-copy-space-good-special-event-like-ramadan-eid-al-fitr_800563-1650.jpg'),
//             ),
//           );
//         },
//       ),
//     );
//     audioPlayer.setAudioSource(_playlist);
//   }
//
//   void _setupListeners() {
//     audioPlayer.playerStateStream.listen((playerState) {
//       isPlay.value = playerState.playing;
//       if (playerState.processingState == ProcessingState.completed) {
//         next();
//       }
//     });
//
//     audioPlayer.currentIndexStream.listen((index) {
//       if (index != null) {
//         surahIndex.value = index;
//         surahName.value = surahController.surahs[index].name ?? 'Unknown Surah';
//       }
//     });
//   }
//
//   Future<void> play() async {
//     try {
//       if (audioPlayer.playing) {
//         await audioPlayer.play();
//       } else {
//         await audioPlayer.play();
//       }
//     } catch (e) {
//       print("Error playing audio: $e");
//     }
//   }
//
//   Future<void> playTrack(int index) async {
//     try {
//       await audioPlayer.seek(Duration.zero, index: index);
//       await audioPlayer.play();
//     } catch (e) {
//       print("Error playing specific track: $e");
//     }
//   }
//
//   void pause() {
//     audioPlayer.pause();
//   }
//
//   void stop() {
//     audioPlayer.stop();
//   }
//
//   void next() {
//     audioPlayer.seekToNext();
//   }
//
//   void previous() {
//     audioPlayer.seekToPrevious();
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
// }
