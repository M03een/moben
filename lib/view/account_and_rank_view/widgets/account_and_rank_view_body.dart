import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'account_content.dart';
import 'custom_tab_bar.dart';

class AccountAndRankViewBody extends StatelessWidget {
  const AccountAndRankViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (screenHeight(context) * 0.03).sh,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppColors.secAccentColor,
                size: 35.0,
              ),
            ),
          ],
        ),
        (screenHeight(context) * 0.02).sh,
        const CustomTabBar(),
        (screenHeight(context) * 0.02).sh,
        const Expanded(child: AccountContent()),
      ],
    );
  }
}





