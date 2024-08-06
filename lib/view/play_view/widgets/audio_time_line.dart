import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';

class AudioTimeLine extends StatelessWidget {
  const AudioTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(

          activeColor: AppColors.accentColor.withOpacity(0.9),
          inactiveColor: AppColors.whiteColor.withOpacity(0.2),
          thumbColor: AppColors.accentColor,
          min: 0.0,
          max: 100.0,
          value: 50,
          onChanged: (value) {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0:33',style: AppStyles.textStyle15.copyWith(color: AppColors.accentColor),),
              const Text('1:15',style: AppStyles.textStyle15,),
            ],
          ),
        ),
      ],
    );
  }
}