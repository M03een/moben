import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/widgets/custom_icon.dart';
import 'package:moben/utils/widgets/snack_bars.dart';

import '../../../utils/colors.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: screenWidth(context) * 0.25,
          height: screenHeight(context) * 0.06,
        ),
        const Spacer(),
        Container(
          width: screenWidth(context) * 0.13,
          height: screenHeight(context) * 0.06,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:  AppColors.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)
          ),
          child: SvgIconButton(
            onTap: () {
              nextUpdateSnackBar();
            },
            width:  screenWidth(context)*0.1,
            height: screenHeight(context)*0.04,
            icon: 'user.svg',
            color: AppColors.secAccentColor,
          ),
        ),
        (screenWidth(context)*0.03).sw,
        Container(
          width: screenWidth(context) * 0.13,
          height: screenHeight(context) * 0.06,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:  AppColors.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)
          ),
          child: SvgIconButton(
            onTap: () {},
            width:  screenWidth(context)*0.1,
            height: screenHeight(context)*0.04,
            icon: 'apps.svg',
            color: AppColors.secAccentColor,
          ),
        ),
      ],
    );
  }
}
