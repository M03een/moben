import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class PlayViewAppbar extends StatelessWidget {
  const PlayViewAppbar({
    super.key, required this.surahName,
  });
  final String surahName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          surahName,
          style: AppStyles.quranTextStyle30,
        ),
        IconButton(
          onPressed: () {
            Get.back(

            );
          },
          icon: const Icon(
            CupertinoIcons.chevron_down,
            size: 30,
            color: AppColors.accentColor,
          ),
        ),
      ],
    );
  }
}
