import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.8,
      height: screenHeight(context) * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          smoothness: 1,
        ),
        color: AppColors.whiteColor.withOpacity(0.2),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedBookmark02,
                color: AppColors.secAccentColor,
                size: 30,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: screenWidth(context) * 0.2,
                height: screenHeight(context) * 0.09,
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    smoothness: 1,
                  ),
                  gradient: const LinearGradient(colors: [
                    AppColors.accentColor,
                    AppColors.secAccentColor
                  ]),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_avatar.png'),
                  ),
                ),
              ),
              (screenWidth(context) * 0.04).sw,
              Column(
                children: [
                  const GradientText(
                    text: 'الخطاب أحمد',
                    gradient: LinearGradient(
                      colors: [AppColors.secAccentColor, AppColors.accentColor],
                    ),
                    style: AppStyles.textStyle24,
                  ),
                  Text(
                    'mmm@gmail.com',
                    style: AppStyles.textStyle15.copyWith(
                      color: AppColors.whiteColor.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          (screenHeight(context) * 0.025).sh,
          Container(
            height: 2,
            width: screenWidth(context) * 0.7,
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16)),
          ),
          (screenHeight(context) * 0.015).sh,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.square_arrow_down_fill,
                    color: AppColors.whiteColor,
                  ),
                  Text(
                    '12',
                    style: AppStyles.textStyle19
                        .copyWith(color: AppColors.whiteColor),
                  )
                ],
              ),
              Container(
                height: screenHeight(context) * 0.05,
                width: 3,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16)),
              ),
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.square_arrow_down_fill,
                    color: AppColors.whiteColor,
                  ),
                  Text(
                    '12',
                    style: AppStyles.textStyle19
                        .copyWith(color: AppColors.whiteColor),
                  )
                ],
              ),
              Container(
                height: screenHeight(context) * 0.05,
                width: 3,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16)),
              ),
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.square_arrow_down_fill,
                    color: AppColors.whiteColor,
                  ),
                  Text(
                    '12',
                    style: AppStyles.textStyle19
                        .copyWith(color: AppColors.whiteColor),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
