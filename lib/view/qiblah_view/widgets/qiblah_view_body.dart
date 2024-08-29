
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/view/qiblah_view/widgets/qiblah_compass.dart';
import 'package:moben/view/qiblah_view/widgets/qiblah_mesh.dart';
import '../../../utils/widgets/glassMorphism.dart';

class QiblahViewBody extends StatefulWidget {
  const QiblahViewBody({super.key});

  @override
  _QiblahViewBodyState createState() => _QiblahViewBodyState();
}

class _QiblahViewBodyState extends State<QiblahViewBody> {
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      // If permission is denied, request it
      status = await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      // Handle the case when the user permanently denies the permission
      openAppSettings();
    }
    // You can add more checks if needed (like if permission is restricted or limited)
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const MeshAnimation(),
          Align(
            alignment: Alignment.center,
            child: GlassMorphism(
              blur: 10,
              opacity: 0.2,
              color: Colors.black,
              height: screenHeight(context) * 0.7,
              width: screenWidth(context) * 0.8,
              borderRadius: BorderRadius.circular(15),
              child: Column(
                children: [
                  const Text(
                    'القبلة',
                    style: AppStyles.quranTextStyle50,
                  ),
                  (screenHeight(context) * 0.1).sh,
                  QiblahCompass(),
                ],
              ),
            ),
          ),
        ],
      ), // Reusable mesh animation component
    );
  }
}