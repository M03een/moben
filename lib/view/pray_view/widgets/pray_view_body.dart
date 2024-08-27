import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:slider_button/slider_button.dart';

class PrayViewBody extends StatelessWidget {
  const PrayViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          (screenHeight(context) * 0.07).sh,
          Container(
            height: screenHeight(context) * 0.3,
            width: screenWidth(context) * 0.9,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                side: BorderSide(
                    color: AppColors.whiteColor.withOpacity(0.3), width: 2),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 20,
                  cornerSmoothing: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'إضافة صلاة',
                  style: AppStyles.textStyle24.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                ),
                (screenHeight(context) * 0.02).sh,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'عدد الركعات',
                      style: AppStyles.textStyle19.copyWith(fontSize: 20),
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: SmoothRectangleBorder(
                          side: BorderSide(
                              color: AppColors.whiteColor.withOpacity(0.3),
                              width: 2),
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 10,
                            cornerSmoothing: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                          ),
                          10.sh,
                          const Text(
                            '0',
                            style: AppStyles.textStyle15,
                          ),
                          10.sh,
                          const Icon(Icons.remove, color: AppColors.whiteColor),
                        ],
                      ),
                    ),
                  ],
                ),
                (screenHeight(context) * 0.03).sh,
                SliderButton(
                  backgroundColor: AppColors.whiteColor.withOpacity(0.2),
                  action: () async {
                    return true;
                  },
                  label: const Text(
                    "ابدأ الصلاة",
                    style: AppStyles.textStyle19,
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.accentColor.withOpacity(0.4),
                    radius: 20,
                    child: SvgPicture.asset(
                      'assets/icons/svg_icons/person-praying.svg',
                      colorFilter: const ColorFilter.mode(
                          AppColors.secAccentColor, BlendMode.srcIn,
                      ),
                      width: 40,
                      height: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
