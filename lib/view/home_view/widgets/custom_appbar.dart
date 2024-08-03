

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:moben/utils/size_config.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "${'1'.tr}, ",
              style: AppStyles.textStyle24.copyWith(
                color: AppColors.accentColor,
                fontFamily: 'Rubik',
              ),
            ),
            TextSpan(
              text: 'عبدالله',
              style: AppStyles.textStyle24.copyWith(fontFamily: 'Rubik'),
            ),
          ]),
        ),
        IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.cube_box,size: screenWidth(context)*0.1,color: AppColors.accentColor,),),

      ],
    );
  }
}
