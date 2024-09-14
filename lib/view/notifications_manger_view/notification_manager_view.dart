import 'package:flutter/material.dart';
import 'package:moben/core/utils/widgets/glow_background.dart';
import 'package:moben/view/notifications_manger_view/widgets/notification_manager_view_body.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/size_config.dart';

class NotificationManagerView extends StatelessWidget {
  const NotificationManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowBackground(
          firstColor: AppColors.accentColor.withOpacity(0),
        secColor: AppColors.secAccentColor.withOpacity(0.35),
        bottomPosition: screenHeight(context) * 0.4,
        rightPosition: screenWidth(context) * 0.1,
          secRightPosition: screenWidth(context) * -0.25,
          secBottomPosition: screenHeight(context) * -0.25,

          child: NotificationViewBody(),
      ),
    );
  }
}
