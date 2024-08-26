import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentSelectedIndex = 0.obs;

  void updateCurrentIndex(int index) {
    currentSelectedIndex.value = index;
  }
}
