import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:get/get.dart';
import '../../../controller/notification_controller.dart';
import '../../../core/utils/size_config.dart';
import 'gradient_container.dart';

class NotificationViewBody extends StatelessWidget {
  NotificationViewBody({super.key});

  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (screenHeight(context) * 0.03).sh,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مذكر العبادات',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.secAccentColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowLeft01,
                  color: AppColors.secAccentColor,
                  size: 35.0,
                ),
              ),
            ],
          ),
          (screenHeight(context) * 0.02).sh,

          // Use Obx to listen for state changes
          Obx(() => GradientContainer(
            title: 'أذكار المساء',
            activeIt: () => notificationController.toggleNotification1(!notificationController.isNotification1Enabled.value),
            setTime: () => notificationController.openTimePickerForNotification(context, 1, 'أذكار المساء'),
            isActive: notificationController.isNotification1Enabled.value,
            isTimeSet: false,
          )),

          Obx(() => GradientContainer(
            title: 'أذكار الصباح',
            activeIt: () => notificationController.toggleNotification2(!notificationController.isNotification2Enabled.value),
            setTime: () => notificationController.openTimePickerForNotification(context, 2, 'أذكار الصباح'),
            isActive: notificationController.isNotification2Enabled.value,
            isTimeSet: false,
          )),

          Obx(() => GradientContainer(
            title: 'قيام الليل',
            activeIt: () => notificationController.toggleNotification3(!notificationController.isNotification3Enabled.value),
            setTime: () => notificationController.openTimePickerForNotification(context, 3, 'قيام الليل'),
            isActive: notificationController.isNotification3Enabled.value,
            isTimeSet: false,
          )),

          Obx(() => GradientContainer(
            title: 'ورد القرأة',
            activeIt: () => notificationController.toggleNotification4(!notificationController.isNotification4Enabled.value),
            setTime: () => notificationController.openTimePickerForNotification(context, 4, 'ورد القرأة'),
            isActive: notificationController.isNotification4Enabled.value,
            isTimeSet: false,
          )),

          Obx(() => GradientContainer(
            title: 'ورد الحفظ',
            activeIt: () => notificationController.toggleNotification5(!notificationController.isNotification5Enabled.value),
            setTime: () => notificationController.openTimePickerForNotification(context, 5, 'ورد الحفظ'),
            isActive: notificationController.isNotification5Enabled.value,
            isTimeSet: false,
          )),



        ],
      ),
    );
  }
}
