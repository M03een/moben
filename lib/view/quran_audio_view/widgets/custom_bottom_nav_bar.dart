import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/widgets/custom_icon.dart';
import '../../../controller/bottom_nav_controller.dart';
import '../../../utils/size_config.dart';
import '../../../utils/widgets/glass_container.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return GlassContainer(
      color: AppColors.primaryColor,
      horizontalPadding: screenWidth(context) * 0.05,
      height: screenHeight(context) * 0.06,
      width: screenWidth(context) * 0.5,
      align: Alignment.center,
      borderRadius: 25,
      border: Border.all(
          color: AppColors.whiteColor.withOpacity(0.2), width: 0.5),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIcon(
              icon: 'waveform.svg',
              onTap: () {
                controller.updateCurrentIndex(0);
              },
              isSelected: controller.currentSelectedIndex.value == 0,
              color: controller.currentSelectedIndex.value == 0
                  ? AppColors.secAccentColor
                  : AppColors.whiteColor.withOpacity(0.2),
            ),
            CustomIcon(
              icon: 'bell-concierge.svg',
              onTap: () {
                controller.updateCurrentIndex(1);
              },
              isSelected: controller.currentSelectedIndex.value == 1,
              color: controller.currentSelectedIndex.value == 1
                  ? AppColors.secAccentColor
                  : AppColors.whiteColor.withOpacity(0.2),
            ),
            CustomIcon(
              icon: 'navigation.svg',
              onTap: () {
                controller.updateCurrentIndex(2);
              },
              isSelected: controller.currentSelectedIndex.value == 2,
              color: controller.currentSelectedIndex.value == 2
                  ? AppColors.secAccentColor
                  : AppColors.whiteColor.withOpacity(0.2),
            ),
            CustomIcon(
              icon: 'layers.svg',
              onTap: () {
                controller.updateCurrentIndex(3);
              },
              isSelected: controller.currentSelectedIndex.value == 3,
              color: controller.currentSelectedIndex.value == 3
                  ? AppColors.secAccentColor
                  : AppColors.whiteColor.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
