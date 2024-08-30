
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:moben/utils/styles.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class ZekrContainer extends StatelessWidget {
  const ZekrContainer({
    super.key,
    required this.child, required this.onTap, required this.totalCount, required this.finishedCount,
  });

  final Widget child;
  final Function() onTap;
  final String totalCount;
  final int finishedCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        width: screenWidth(context) * 0.9,
        height: screenHeight(context) * 0.6,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.accentColor.withOpacity(0.6),
              AppColors.secAccentColor.withOpacity(0.6),
            ],
          ),
          borderRadius:
          SmoothBorderRadius(cornerRadius: 25, cornerSmoothing: 0.6),
        ),
        child: Column(

          children: [
            child,
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$totalCount/$finishedCount',style: AppStyles.textStyle24.copyWith(color: AppColors.primaryColor),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
