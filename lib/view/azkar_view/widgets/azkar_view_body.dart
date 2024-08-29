import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/custom_icon.dart';

import 'azkar_item.dart';

class AzkarViewBody extends StatelessWidget {
  const AzkarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.06),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'أذكار',
                  style: AppStyles.textStyle35.copyWith(
                    color: AppColors.secAccentColor,
                  ),
                ),
                SvgIconButton(
                  onTap: () {
                    Get.back();
                  },
                  icon: 'left_arrow.svg',
                  color: AppColors.secAccentColor,
                ),
              ],
            ),
            (screenHeight(context) * 0.02).sh,
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const AzkarrItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

