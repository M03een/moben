import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/gradient_text.dart';

class CountText extends StatelessWidget {
  const CountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('22 ',style: AppStyles.textStyle35,),
        GradientText(
          text: '/ 31',
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              AppColors.accentColor.withOpacity(0.6),
              AppColors.secAccentColor.withOpacity(0.6),
            ],
          ),
          style: AppStyles.textStyle35,
        ),

      ],
    );
  }
}
