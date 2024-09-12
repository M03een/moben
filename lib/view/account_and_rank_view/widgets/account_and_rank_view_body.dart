import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/controller/account_view_controller.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/view/account_and_rank_view/widgets/account_content.dart';
import 'package:moben/view/account_and_rank_view/widgets/ranked_content.dart';
import 'custom_tab_bar.dart';

class AccountAndRankViewBody extends StatelessWidget {
  AccountAndRankViewBody({super.key});

 final AccountViewController controller = Get.put(AccountViewController());

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
         CustomTabBar(),
        (screenHeight(context) * 0.02).sh,
        Obx(() {
          return Expanded(
            child: controller.isAccount.value
                ? const AccountContent()
                : const RankContent(),
          );
        }),
      ],
    );
  }
}
