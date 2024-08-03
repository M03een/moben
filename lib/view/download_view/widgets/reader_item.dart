import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';

class ReaderItem extends StatelessWidget {
  final String readerName;
  final String readerImage;
  final int downloaded;

  const ReaderItem({
    super.key,
    required this.readerName,
    required this.readerImage,
    required this.downloaded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: screenWidth(context) * 0.3,
      height: screenHeight(context) * 0.1,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(
            readerImage,
          ),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [
                  AppColors.accentColor,
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: r"114\",
                      style: AppStyles.textStyle24,
                    ),
                    TextSpan(
                      text: " $downloaded",
                      style: AppStyles.textStyle30,
                    ),
                  ]),
                ),
                Text(
                  readerName,
                  style: AppStyles.textStyle19,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
