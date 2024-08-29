import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moben/view/azkar_view/azkar_view.dart';
import 'package:moben/view/azkar_view/zekr_view.dart';
import 'package:moben/view/download_view/download_view.dart';
import 'package:moben/view/play_view/play_view.dart';
import 'package:moben/view/splash_view/splash%20view.dart';

import '../view/quran_audio_view/widgets/bottom_navigation_bar.dart';

class AppRouter {
  static String splashViewPath = '/';
  static String bottomViewPath = '/bottomViewPath';
  static String downloadViewPath = '/download';
  static String playViewPath = '/play';
  static String azkarViewPath = '/azkar';
  static String zekrViewPath = '/zekr';
  static List<GetPage<dynamic>> routes = [
    GetPage(name: splashViewPath, page: () => const SplashView()),
    GetPage(name: bottomViewPath, page: () =>  BottomNavBar()),
    GetPage(name: downloadViewPath, page: () => const DownloadView()),
    GetPage(name: playViewPath, page: () =>   const PlayView()),
    GetPage(name: azkarViewPath, page: () =>   const AzkarView()),
    GetPage(name: zekrViewPath, page: () =>   const ZekrView()),
  ];
}
