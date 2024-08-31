import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';

class AudioTimeLine extends StatelessWidget {
  const AudioTimeLine({
    super.key, required this.value, required this.max, required this.onChanged, required this.playedDuration, required this.totalDuration,
  });

  final String playedDuration;
  final String totalDuration;
  final double value;
  final double max;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(

          activeColor: AppColors.accentColor.withOpacity(0.9),
          inactiveColor: AppColors.whiteColor.withOpacity(0.2),
          thumbColor: AppColors.accentColor,
          min: 0.0,
          max: max,
          value: value,
          onChanged: onChanged,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(playedDuration,style: AppStyles.textStyle15,),
              Text(totalDuration,style: AppStyles.textStyle15.copyWith(color: AppColors.accentColor)),
            ],
          ),
        ),
      ],
    );
  }
}