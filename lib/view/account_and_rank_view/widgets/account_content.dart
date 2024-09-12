import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/view/account_and_rank_view/widgets/profile_card.dart';

import 'custom_tab_bar.dart';
import 'details_list.dart';


class AccountContent extends StatelessWidget {
  const AccountContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (screenHeight(context) * 0.04).sh,

        const ProfileCard(),
        (screenHeight(context) * 0.025).sh,
        Text(
          'التفاصيل',
          style: AppStyles.textStyle24.copyWith(color: AppColors.accentColor),
        ),
        (screenHeight(context) * 0.025).sh,
        const DetailsList(),
      ],
    );
  }
}
