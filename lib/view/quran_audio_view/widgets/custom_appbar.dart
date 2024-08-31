import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/custom_icon.dart';

import '../../../core/utils/colors.dart';

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
          width: screenWidth(context)*0.15,
          height: screenHeight(context)*0.06,
        ),
        const Spacer(),
        SvgIconButton(
          onTap: () {
            Get.toNamed(AppRouter.azkarViewPath);
          },
          width: screenWidth(context)*0.01,
          height: screenHeight(context)*0.04,
          icon: 'layers.svg',
          color: AppColors.secAccentColor,
        ),
      ],
    );
  }
}
