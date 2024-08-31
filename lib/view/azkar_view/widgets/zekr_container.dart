import 'package:flutter/material.dart';
import 'package:moben/core/utils/styles.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';

class ZekrContainer extends StatelessWidget {
  const ZekrContainer({
    super.key,
    required this.onTap,
    required this.totalCount,
    required this.finishedCount,
    required this.isZekrFinished,
    required this.zekr,
  });

  final Function() onTap;
  final String totalCount;
  final String zekr;
  final int finishedCount;
  final bool isZekrFinished;

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
              AppColors.accentColor.withOpacity(isZekrFinished ? 0.1 : 0.6),
              AppColors.secAccentColor.withOpacity(isZekrFinished ? 0.1 : 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth(context) * 0.9,
              height: screenHeight(context) * 0.5,
              child: SingleChildScrollView(
                child: Text(
                  zekr,
                  textAlign: TextAlign.center,
                  style: AppStyles.quranTextStyle30.copyWith(
                    color: isZekrFinished
                        ? AppColors.whiteColor.withOpacity(0.1)
                        : AppColors.primaryColor,
                    height: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$totalCount/$finishedCount',
                  style: AppStyles.textStyle24.copyWith(
                    color: isZekrFinished
                        ? AppColors.whiteColor.withOpacity(0.1)
                        : AppColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
