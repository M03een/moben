import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/glass_container.dart';

class ReaderAndDownloadWidget extends StatelessWidget {
  const ReaderAndDownloadWidget({
    super.key, required this.readerName, required this.isDownloaded, required this.percentage,
  });
  final String readerName;
  final bool isDownloaded;
  final String percentage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GlassContainer(
          horMargin: 5,
          height: screenHeight(context) * 0.15,
          width: screenWidth(context) * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.person_fill,
                      color: AppColors.accentColor,
                      size: 25,
                    ),
                    Text(
                      'القارئ',
                      style: AppStyles.textStyle19
                          .copyWith(color: AppColors.accentColor),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      readerName,
                      style: AppStyles.textStyle15.copyWith(
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.chevron_compact_down,
                        color: AppColors.accentColor,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GlassContainer(
            height: screenHeight(context) * 0.15,
            width: 200,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: (screenHeight(context) * 0.1),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Text(
                          'جاري التحميل...${70}',
                          style: AppStyles.textStyle15.copyWith(
                              color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
