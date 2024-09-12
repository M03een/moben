import 'package:flutter/material.dart';

import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/view/account_and_rank_view/widgets/not_first_ranked.dart';

import 'package:smooth_corner/smooth_corner.dart';

class RankedBaseContainer extends StatelessWidget {
  const RankedBaseContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.8,
      height: screenHeight(context) * 0.3,
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          smoothness: 1,
        ),
        color: AppColors.whiteColor.withOpacity(0.2),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [NotFirstRankWidget(), NotFirstRankWidget()],
      ),
    );
  }
}
