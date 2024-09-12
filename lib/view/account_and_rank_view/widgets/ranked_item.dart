import 'package:flutter/material.dart';

import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:smooth_corner/smooth_corner.dart';

class RankedItem extends StatelessWidget {
  const RankedItem({
    super.key,
    required this.isFirst,
  });

  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: (screenWidth(context) - (screenWidth(context) * 0.9)),
        vertical: screenHeight(context) * 0.005,
      ),
      width: screenWidth(context) * 0.8,
      height: screenHeight(context) * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          smoothness: 1,
        ),

        gradient: isFirst ? LinearGradient(
          colors: [
            AppColors.secAccentColor.withOpacity(0.4),
            AppColors.accentColor.withOpacity(0.4)
          ],
        ) :  LinearGradient(colors: [AppColors.whiteColor.withOpacity(0.2),AppColors.whiteColor.withOpacity(0.2)]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin:
            EdgeInsets.symmetric(vertical: screenHeight(context) * 0.009),
            width: screenWidth(context) * 0.2,
            height: screenHeight(context) * 0.065,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [AppColors.secAccentColor, AppColors.accentColor]),
                image: DecorationImage(
                    image: AssetImage('assets/images/profile_avatar.png'))),
          ),
          Text(
            'الخطاب',
            style: AppStyles.textStyle27.copyWith(
              color: isFirst ? AppColors.whiteColor : AppColors.accentColor,
            ),
          ),
          const Spacer(),
          Text(
            '111',
            style: AppStyles.textStyle40.copyWith(
              color: isFirst ? AppColors.whiteColor : AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}