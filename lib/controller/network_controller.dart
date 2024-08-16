import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkController extends GetxController {
  var isInternetConnected = false.obs;
  StreamSubscription? internetConnectionStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    internetConnectionStreamSubscription = InternetConnection().onStatusChange.listen(
          (event) {
        switch (event) {
          case InternetStatus.connected:
            isInternetConnected.value = true;
            break;
          case InternetStatus.disconnected:
            isInternetConnected.value = false;
            break;
          default:
            isInternetConnected.value = false;
            break;
        }
      },
    );
  }

  @override
  void onClose() {
    internetConnectionStreamSubscription?.cancel();
    super.onClose();
  }
}
