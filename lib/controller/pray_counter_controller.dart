import 'package:get/get.dart';

class PrayCounterController extends GetxController {
  var rakaa = 0;
  var sagda = 0;
  var tashahod = 0;


  rakaaIncrement() {
    rakaa++;
    update();
  }

  rakaaDecrement() {
    if (rakaa > 0) {
      rakaa = 0;
    } else {
      rakaa--;
    }
    update();
  }



  sagdaIncrement() {
    sagda++;
    update();
  }

  sagdaDecrement() {
    if (sagda > 0) {
      sagda = 0;
    } else {
      sagda--;
    }
    update();
  }



  tashahodIncrement() {
    tashahod++;
    update();
  }

  tashahodDecrement() {
    if (tashahod > 0) {
      tashahod = 0;
    } else {
      tashahod--;
    }
    update();
  }




}


