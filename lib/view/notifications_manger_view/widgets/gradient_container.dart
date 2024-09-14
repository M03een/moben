import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_icon.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.title,
    required this.setTime,
    required this.activeIt,
    required this.isTimeSet,
    required this.isActive,
  });

  final String title;
  final bool isTimeSet;
  final bool isActive;
  final Function() setTime;
  final Function() activeIt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight(context) * 0.005,
      ),
      width: screenWidth(context) * 0.9,
      height: screenHeight(context) * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            smoothness: 1,
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.secAccentColor.withOpacity(0.4),
              AppColors.accentColor.withOpacity(0.4)
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.textStyle27.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          const Spacer(),
          SvgIconButton(
            onTap: setTime,
            icon: 'alarm-clock.svg',
            color: isTimeSet
                ? AppColors.secAccentColor
                : AppColors.whiteColor.withOpacity(0.3),
          ),
          (screenWidth(context) * 0.05).sw,
          SvgIconButton(
            onTap: activeIt,
            icon: 'bell.svg',
            color: isActive
                ? AppColors.secAccentColor
                : AppColors.whiteColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
