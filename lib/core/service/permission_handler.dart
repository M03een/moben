import 'package:permission_handler/permission_handler.dart';

class MobenPermissionHandler {
  Future<void> checkNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }
  }

  Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      var result = await Permission.camera.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  Future<bool> checkAndRequestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.status.isDenied) {
      final status = await Permission.scheduleExactAlarm.request();
      return status.isGranted;
    }
    return true;
  }
}