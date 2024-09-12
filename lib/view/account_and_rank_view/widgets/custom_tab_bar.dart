import 'package:flutter/material.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: screenWidth(context) * 0.4,
            height: screenHeight(context) * 0.06,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accentColor,
                  AppColors.secAccentColor,
                ],
              ),
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(13),
              ),
            ),
            child: Text(
              'حسابي',
              style: AppStyles.textStyle24.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: screenWidth(context) * 0.4,
            height: screenHeight(context) * 0.06,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.2),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(13),
              ),
            ),
            child: GradientText(
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
  }
}
