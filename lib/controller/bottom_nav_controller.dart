import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController with WidgetsBindingObserver {
  var currentSelectedIndex = 0.obs;
  var isBottomNavBarVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0.0;

    if (isKeyboardVisible) {
      isBottomNavBarVisible.value = false;
    } else {
      isBottomNavBarVisible.value = true;
    }
  }

  void updateCurrentIndex(int index) {
    currentSelectedIndex.value = index;
  }
}
