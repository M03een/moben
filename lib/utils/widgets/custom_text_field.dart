import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../colors.dart';
import '../size_config.dart';
import 'glass_container.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 12,
      height: screenHeight(context) * 0.058,
      width: screenWidth(context) * 0.9,
      verticalPadding: 10,
      horizontalPadding: 10,
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: AppColors.accentColor.withOpacity(0.6),
            ),
            hintText: '2'.tr,
            hintStyle: TextStyle(
              color: AppColors.accentColor.withOpacity(0.6),
              fontSize: 20,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
