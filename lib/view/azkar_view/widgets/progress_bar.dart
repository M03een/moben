import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../controller/azkar_controller.dart';

class ProgressBar extends GetView<AzkarController> {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    double progressSpace = screenWidth(context) * 0.8;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.03),
      child: Container(
        alignment: Alignment.centerRight,
        width: progressSpace,
        height: screenHeight(context) * 0.01,
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.1),
          borderRadius:
          SmoothBorderRadius(cornerRadius: 25, cornerSmoothing: 0.6),
        ),
        child: Obx(() {
          return Container(
            width: progressSpace * controller.totalProgress.value,
            height: screenHeight(context) * 0.01,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  AppColors.accentColor.withOpacity(0.6),
                  AppColors.secAccentColor.withOpacity(0.6),
                ],
              ),
              borderRadius:
              SmoothBorderRadius(cornerRadius: 25, cornerSmoothing: 0.6),
            ),
          );
        }),
      ),
    );
  }
}