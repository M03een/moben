import 'package:get/get.dart';

class CounterController extends GetxController {
  var counter = 0;
  var customText = 'اضغط لكاتبة ذكر'.obs;

  increment() {
    counter++;
    update();
  }

  reset() {
    counter = 0;
    update();
  }

  updateCustomText(String text) {
    customText.value = text;
    update();
  }
}
