import 'package:flutter/material.dart';

import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/view/account_and_rank_view/widgets/ranked_board.dart';
import 'package:moben/view/account_and_rank_view/widgets/ranked_items_list.dart';

class RankContent extends StatelessWidget {
  const RankContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (screenHeight(context) * 0.04).sh,
        const RankedBoard(),
        (screenHeight(context) * 0.025).sh,
        Text(
          'الترتيب',
          style: AppStyles.textStyle24
              .copyWith(color: AppColors.accentColor),
        ),
        const RankedItemsList(),
      ],
    );
  }
}
