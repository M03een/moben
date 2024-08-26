import 'package:get/get.dart';
class CounterController extends GetxController {
  var counter = 0;
  increment() {
    counter++;
    update();
  }
  reset(){
    counter = 0;
    update();
  }
}