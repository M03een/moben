import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moben/view/azkar_view/azkar_view.dart';
import 'package:moben/view/azkar_view/zekr_view.dart';
import 'package:moben/view/download_view/download_view.dart';
import 'package:moben/view/login_and_register_view/login_view.dart';
import 'package:moben/view/login_and_register_view/register_view.dart';
import 'package:moben/view/play_view/play_view.dart';

import '../view/quran_audio_view/widgets/bottom_navigation_bar.dart';

class AppRouter {
  static String loginViewPath = '/';
  static String registerViewPath = '/register';
  static String bottomNavigationPath = '/navigation';
  static String downloadViewPath = '/download';
  static String playViewPath = '/play';
  static String azkarViewPath = '/azkar';
  static String zekrViewPath = '/zekr';
  static List<GetPage<dynamic>> routes = [
    GetPage(name: loginViewPath, page: () =>  const LoginView()),
    GetPage(name: registerViewPath, page: () =>   RegisterView()),
    GetPage(name: bottomNavigationPath, page: () =>  BottomNavBar()),
    GetPage(name: downloadViewPath, page: () => const DownloadView()),
    GetPage(name: playViewPath, page: () =>   const PlayView()),
    GetPage(name: azkarViewPath, page: () =>   const AzkarView()),
    GetPage(name: zekrViewPath, page: () =>   const ZekrView()),
  ];
}
