import 'package:flutter/material.dart';

import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';

class NotFirstRankWidget extends StatelessWidget {
  const NotFirstRankWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '#2',
          style: AppStyles.textStyle35.copyWith(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.009),
          width: screenWidth(context) * 0.3,
          height: screenHeight(context) * 0.07,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [AppColors.secAccentColor, AppColors.accentColor]),
              image: DecorationImage(
                  image: AssetImage('assets/images/profile_avatar.png'))),
        ),
        const GradientText(
          text: 'فؤش',
          gradient: LinearGradient(
              colors: [AppColors.secAccentColor, AppColors.accentColor]),
          style: AppStyles.textStyle24,
        ),
        (screenHeight(context) * 0.009).sh,
        const GradientText(
          text: '112',
          gradient: LinearGradient(
              colors: [AppColors.secAccentColor, AppColors.accentColor]),
          style: AppStyles.textStyle35,
        ),
      ],
    );
  }
}
