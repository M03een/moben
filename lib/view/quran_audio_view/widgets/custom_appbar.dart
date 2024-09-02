import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: screenWidth(context) * 0.15,
          height: screenHeight(context) * 0.06,
        ),
        const Spacer(),
        SvgIconButton(
          onTap: () {

              surahController.key.currentState!.openEndDrawer();
          },
          width: screenWidth(context) * 0.05,
          height: screenHeight(context) * 0.04,
          icon: 'layers.svg',
          color: AppColors.secAccentColor,
        ),
      ],
    );
  }
}
