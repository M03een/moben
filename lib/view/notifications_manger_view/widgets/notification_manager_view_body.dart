import 'package:flutter/material.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';
import '../../../controller/notification_controller.dart';
import 'package:get/get.dart';

class NotificationViewBody extends StatelessWidget {
  NotificationViewBody({super.key});

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNotificationComponent(
            context,
            "Notification 1",
            notificationController.isNotification1Enabled,
            notificationController.toggleNotification1,
            () =>
                notificationController.openTimePickerForNotification1(context),
          ),
          const SizedBox(height: 20),
          _buildNotificationComponent(
            context,
            "Notification 2",
            notificationController.isNotification2Enabled,
            notificationController.toggleNotification2,
            () =>
                notificationController.openTimePickerForNotification2(context),
          ),
          const SizedBox(height: 20),
          _buildNotificationComponent(
            context,
            "Notification 3",
            notificationController.isNotification3Enabled,
            notificationController.toggleNotification3,
            () =>
                notificationController.openTimePickerForNotification3(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationComponent(
    BuildContext context,
    String title,
    RxBool isChecked,
    Function(bool?) onChanged,
    VoidCallback onIconPressed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Checkbox(
              value: isChecked.value,
              onChanged: onChanged,
            )),
        GradientText(
          text: title,
          gradient: const LinearGradient(
            colors: [AppColors.secAccentColor, AppColors.accentColor],
          ),
          style: AppStyles.quranTextStyle30,
        ),
        IconButton(
          icon: const Icon(Icons.alarm),
          onPressed: onIconPressed,
        ),
      ],
    );
  }
}
