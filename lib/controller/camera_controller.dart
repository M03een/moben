import 'package:camera/camera.dart';
import 'package:get/get.dart';
import '../core/service/permission_handler.dart';

class CameraControllerX extends GetxController {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  int selectedCameraIndex = 0;
  final MobenPermissionHandler _permissionHandler = MobenPermissionHandler();

  // Method to initialize the camera after permission check
  Future<void> initializeCamera(List<CameraDescription> availableCameras) async {
    bool hasPermission = await _permissionHandler.checkCameraPermission();

    if (!hasPermission) {
      Get.snackbar("Permission Denied", "Camera permission is required");
      return;
    }

    cameras = availableCameras;

    if (cameras.isNotEmpty) {
      controller = CameraController(
        cameras[selectedCameraIndex],
        ResolutionPreset.high,
      );
      try {
        await controller?.initialize();
        update(); // Update the UI
      } catch (e) {
        print('Error initializing camera: $e');
      }
    }
  }

  // Method to toggle between front and back cameras
  void toggleCamera() async {
    selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
    await initializeCamera(cameras);
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
