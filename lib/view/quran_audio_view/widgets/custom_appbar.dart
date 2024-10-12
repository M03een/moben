import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/custom_icon.dart';
import '../../../controller/surah_controller.dart';
import '../../../core/utils/colors.dart';

class CustomAppbar extends StatelessWidget {
   CustomAppbar({super.key});
  final SurahController surahController = Get.put(SurahController());
  


  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery
        .of(context)
        .size
        .width >= 600;
    return Row(
      mainAxisAlignment:isTablet? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: [

        Image.asset(
          'assets/images/logo.png',
          width: screenWidth(context) * 0.15,
          height: screenHeight(context) * 0.06,
        ),
        Visibility(
          visible: !isTablet,
          child: SvgIconButton(
            onTap: () {

                surahController.key.currentState!.openEndDrawer();
            },
            width: screenWidth(context) * 0.05,
            height: screenHeight(context) * 0.04,
            icon: 'layers.svg',
            color: AppColors.secAccentColor,
          ),
        ),
      ],
    );
  }
}
