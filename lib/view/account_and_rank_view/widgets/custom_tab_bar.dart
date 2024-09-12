import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';

import '../../../controller/account_view_controller.dart';

class CustomTabBar extends StatelessWidget {
  CustomTabBar({
    super.key,
  });

  final AccountViewController controller = Get.put(AccountViewController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              controller.toggleTabViewToAccount();
            },
            child: Container(
              width: screenWidth(context) * 0.4,
              height: screenHeight(context) * 0.06,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: controller.isAccount.value
                    ? const LinearGradient(
                  colors: [
                    AppColors.accentColor,
                    AppColors.secAccentColor,
                  ],
                )
                    : LinearGradient(
                  colors: [
                    AppColors.whiteColor.withOpacity(0.2),
                    AppColors.secAccentColor.withOpacity(0.2),
                  ],
                ),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(13),
                ),
              ),
              child: !controller.isAccount.value
                  ?
              GradientText(
                text: 'حسابي',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                ),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.accentColor,
                    AppColors.secAccentColor,
                  ],
                ),
              ):Text(
                'حسابي',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.toggleTabViewToRank();
            },
            child: Container(
              width: screenWidth(context) * 0.4,
              height: screenHeight(context) * 0.06,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: controller.isAccount.value
                    ? LinearGradient(
                  colors: [
                    AppColors.whiteColor.withOpacity(0.2),
                    AppColors.secAccentColor.withOpacity(0.2),
                  ],
                )
                    : const LinearGradient(
                  colors: [
                    AppColors.accentColor,
                    AppColors.secAccentColor,
                  ],
                ),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(13),
                ),
              ),
              child: !controller.isAccount.value
                  ? Text(
                'الترتيب',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                ),
              )
                  : GradientText(
                text: 'الترتيب',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                ),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.accentColor,
                    AppColors.secAccentColor,
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
