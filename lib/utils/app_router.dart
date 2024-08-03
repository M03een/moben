import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moben/view/download_view/download_view.dart';
import 'package:moben/view/home_view/home_view.dart';
import 'package:moben/view/play_view/play_view.dart';

class AppRouter {
  static String homeViewPath = '/';
  static String downloadViewPath = '/download';
  static String playViewPath = '/play';
  static List<GetPage<dynamic>> routes = [
    GetPage(name: homeViewPath, page: () => const HomeView()),
    GetPage(name: downloadViewPath, page: () => const DownloadView()),
    GetPage(name: playViewPath, page: () => const PlayView()),
  ];
}
