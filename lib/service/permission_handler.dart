import 'package:permission_handler/permission_handler.dart';

class MobenPermissionHandler{

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }
  }

}