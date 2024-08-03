import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moben/view/home_view/home_view.dart';

class AppRouter {
  static String homeViewPath = '/';
  static List<GetPage<dynamic>> routes = [
    GetPage(name: homeViewPath, page: () => const HomeView()),
  ];
}
