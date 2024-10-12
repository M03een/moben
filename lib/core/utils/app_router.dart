import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moben/core/shared_prefrences/moben_shared_pref.dart';
import 'package:moben/view/account_and_rank_view/account_and_rank_view.dart';
import 'package:moben/view/azkar_view/azkar_view.dart';
import 'package:moben/view/azkar_view/zekr_view.dart';
import 'package:moben/view/download_view/downloaded_surah_view.dart';
import 'package:moben/view/download_view/widgets/reader_downloaded_surahs_list.dart';
import 'package:moben/view/generate_image_view/views/all_images_view.dart';
import 'package:moben/view/generate_image_view/views/single_image_view.dart';
import 'package:moben/view/login_and_register_view/login_view.dart';
import 'package:moben/view/login_and_register_view/register_view.dart';
import 'package:moben/view/notifications_manger_view/notification_manager_view.dart';
import 'package:moben/view/play_view/play_view.dart';
import 'package:moben/view/pray_view/widgets/camera_view.dart';

import '../../view/quran_audio_view/widgets/bottom_navigation_bar.dart';
import 'package:camera/camera.dart';

class AppRouter {
  MobenSharedPref authSharedPref = MobenSharedPref();



  static String loginViewPath = '/';
  static String registerViewPath = '/register';
  static String bottomNavigationPath = '/navigation';
  static String downloadViewPath = '/download';
  static String playViewPath = '/play';
  static String azkarViewPath = '/azkar';
  static String zekrViewPath = '/zekr';
  static String readerDownloadedListPath = '/readerDownloadedList';
  static String downloadedSurahPlayerViewPath = '/downloadedPlayer';
  static String accountAndRankViewPath = '/accountAndRank';
  static String notificationsManagerViewPath = '/notificationsManager';
  static String cameraViewPath = '/camera';
  static String allImagesViewPath = '/allImages';

  static List<GetPage<dynamic>> getRoutes(List<CameraDescription> cameras) {
    return [
      GetPage(name: loginViewPath, page: () => const LoginView()),
      GetPage(name: registerViewPath, page: () => const RegisterView()),
      GetPage(name: bottomNavigationPath, page: () => BottomNavBar()),
      GetPage(name: downloadViewPath, page: () => const DownloadedSurahView()),
      GetPage(name: playViewPath, page: () => const PlayView()),
      GetPage(name: azkarViewPath, page: () => const AzkarView()),
      GetPage(name: zekrViewPath, page: () => const ZekrView()),
      GetPage(name: allImagesViewPath, page: () =>  AllImagesView()),
      GetPage(
          name: readerDownloadedListPath,
          page: () => ReaderDownloadedSurahsList()),
      GetPage(
          name: downloadedSurahPlayerViewPath,
          page: () => ReaderDownloadedSurahsList()),
      GetPage(
          name: accountAndRankViewPath, page: () => const AccountAndRankView()),
      GetPage(
          name: notificationsManagerViewPath,
          page: () => const NotificationManagerView()),
      GetPage(
        name: cameraViewPath,
        page: () => CameraView(cameras: cameras),
      ),
    ];
  }
}
