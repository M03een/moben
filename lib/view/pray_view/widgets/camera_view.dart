import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';
import 'package:moben/core/utils/widgets/gradient_button.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';

import '../../../controller/camera_controller.dart';

class CameraView extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CameraView({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    final CameraControllerX cameraController = Get.put(CameraControllerX());

    cameraController.initializeCamera(cameras);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CameraControllerX>(
              builder: (controller) {
                if (controller.controller == null ||
                    !controller.controller!.value.isInitialized) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: screenHeight(context),
                        child: CameraPreview(controller.controller!),
                      ),
                      GlassContainer(
                        height: screenHeight(context) * 0.2,
                        width: double.infinity,
                        color: AppColors.primaryColor.withOpacity(0.5),
                        horMargin: screenWidth(context) * 0.05,
                        virMargin: screenHeight(context) * 0.02,
                        verticalPadding: screenHeight(context) * 0.02,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildPrayItemColumn(
                                  context: context,
                                  title: 'الركعات',
                                  value: 3,
                                ),
                                verDivider(context),
                                buildPrayItemColumn(
                                  context: context,
                                  title: 'السجدات',
                                  value: 5,
                                ),
                                verDivider(context),
                                buildPrayItemColumn(
                                  context: context,
                                  title: 'التشهد',
                                  value: 1,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'الحالة: واقف',
                              style: AppStyles.textStyle19.copyWith(
                                color: AppColors.secAccentColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          // Button to toggle the camera
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GradientButton(
                  width: screenWidth(context) * 0.3,
                  onTap: () {
                    cameraController.toggleCamera();
                  },
                  child: Text(
                    'تبديل الكاميرا',
                    style: AppStyles.textStyle19.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                GlassContainer(
                  align: Alignment.center,
                  height: screenHeight(context) * 0.07,
                  width: screenWidth(context) * 0.3,
                  color: AppColors.errorColor,
                  onTap: (){
                    cameraController.onClose();
                    Get.back();
                  },
                  child: Text(
                    'إيقاف',
                    style: AppStyles.textStyle19.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildPrayItemColumn(
      {required BuildContext context,
      required String title,
      required,
      required int value}) {
    return Column(
      children: [
        const GradientText(
            text: 'عدد الركعات',
            gradient: LinearGradient(
              colors: [AppColors.secAccentColor, AppColors.accentColor],
            ),
            style: AppStyles.textStyle19),
        (screenHeight(context) * 0.01).sh,
        Text(
          '12',
          style:
              AppStyles.textStyle35.copyWith(color: AppColors.secAccentColor),
        )
      ],
    );
  }

  Container verDivider(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.08,
      width: 3,
      decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}
