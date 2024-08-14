import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/widgets/gradient_text.dart';
import 'package:moben/utils/widgets/snack_bars.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const GradientText(
              text: 'السلام عليكم',
              gradient: LinearGradient(
                  colors: [AppColors.accentColor, AppColors.secAccentColor]),
              style: AppStyles.textStyle24,
            ),
            (screenWidth(context) * 0.01).sw,
            const Text(
              ',عبدالله ',
              style: AppStyles.textStyle24,
            )
          ],
        ),

        IconButton(
          onPressed: () {
           nextUpdateSnackBar();
          },
          icon: Icon(
            CupertinoIcons.cube_box,
            size: screenWidth(context) * 0.1,
            color: AppColors.accentColor,
          ),
        ),
      ],
    );
  }
}
