
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../colors.dart';
import '../size_config.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.child,
    required this.width,
    required this.onTap,
  });

  final Widget child;
  final double width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      splashColor: AppColors.secAccentColor.withOpacity(0.3),
      minWidth: width,
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        height: screenHeight(context) * 0.07,
        width: width,
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            smoothness: 0.6,
          ),
          gradient: const LinearGradient(
            colors: [
              AppColors.secAccentColor,
              AppColors.accentColor,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
