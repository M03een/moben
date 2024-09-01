import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/glass_container.dart';

class ReadingButton extends StatelessWidget {
  const ReadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: screenHeight(context) * 0.06,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HugeIcon(
            icon: HugeIcons.strokeRoundedBook01,
            color: AppColors.accentColor,
            size: 24.0,
          ),
          (screenHeight(context) * 0.01).sw,
          Text(
            'قراءة',
            style: AppStyles.textStyle19.copyWith(color: AppColors.accentColor),
          ),
        ],
      ),
    );
  }
}
