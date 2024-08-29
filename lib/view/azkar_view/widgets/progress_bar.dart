import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.03),
      child: Container(
        alignment: Alignment.centerRight,
        width: screenWidth(context) * 0.8,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.1),
          borderRadius:
          SmoothBorderRadius(cornerRadius: 25, cornerSmoothing: 0.6),
        ),
        child: Container(
          width: screenWidth(context) * 0.5,
          height: 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                AppColors.accentColor.withOpacity(0.6),
                AppColors.secAccentColor.withOpacity(0.6),
              ],
            ),
            borderRadius:
            SmoothBorderRadius(cornerRadius: 25, cornerSmoothing: 0.6),
          ),
        ),
      ),
    );
  }
}
