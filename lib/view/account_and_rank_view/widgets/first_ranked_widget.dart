import 'package:flutter/material.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
class FirstRankedWidget extends StatelessWidget {
  const FirstRankedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.35,
      width: screenWidth(context) * 0.3,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [AppColors.secAccentColor, AppColors.accentColor]),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Text(
            'الخطاب',
            style: AppStyles.textStyle27.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Container(
            margin:
            EdgeInsets.symmetric(vertical: screenHeight(context) * 0.009),
            width: screenWidth(context) * 0.32,
            height: screenHeight(context) * 0.073,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/profile_avatar.png'))),
          ),
          const Spacer(),
          Text(
            '150',
            style: AppStyles.textStyle40.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 60,
            ),
          ),
          (screenHeight(context) * 0.02).sh,
        ],
      ),
    );
  }
}