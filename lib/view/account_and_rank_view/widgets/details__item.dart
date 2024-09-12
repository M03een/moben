import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';
import 'package:smooth_corner/smooth_corner.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    super.key,
  });

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
        color: AppColors.whiteColor.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                text: 'أذكار الصباح',
                gradient: const LinearGradient(
                  colors: [AppColors.secAccentColor, AppColors.accentColor],
                ),
                style: AppStyles.textStyle19.copyWith(fontSize: 22),
              ),
              (screenHeight(context) * 0.005).sh,
              Text(
                textAlign: TextAlign.start,
                '32-1-2034',
                style: AppStyles.textStyle15.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
          const GradientText(
            text: '+4',
            gradient: LinearGradient(
              colors: [AppColors.secAccentColor, AppColors.accentColor],
            ),
            style: AppStyles.textStyle40,
          ),
        ],
      ),
    );
  }
}
