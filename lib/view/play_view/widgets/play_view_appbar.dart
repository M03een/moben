import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/custom_icon.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class PlayViewAppbar extends StatelessWidget {
  const PlayViewAppbar({
    super.key,
    required this.surahName,
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
        SvgIconButton(
          onTap: () { Get.back();},
          icon: 'left_arrow.svg',
          color: AppColors.accentColor,
        ),
      ],
    );
  }
}
