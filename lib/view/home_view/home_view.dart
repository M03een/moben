import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/glass_container.dart';
import 'package:moben/utils/widgets/glow_background.dart';
import 'package:moben/view/home_view/widgets/home_view_body.dart';

import '../../controller/audio_controller.dart';
import '../../controller/surah_controller.dart';
import '../../utils/colors.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AudioController audioController = Get.put(AudioController());
  final SurahController surahController = Get.put(SurahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlowBackground(
            firstColor: AppColors.accentColor.withOpacity(0.35),
            secColor: AppColors.secAccentColor.withOpacity(0.35),
            bottomPosition: screenHeight(context) * 0.4,
            rightPosition: screenWidth(context) * 0.1,
            child: const HomeViewBody(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GlassContainer(
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
              color: Colors.transparent,
              virMargin: 10,
              horizontalPadding: 10,
              height: 70,
              width: screenWidth(context) * 0.9,
              align: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اسم السورة',
                    style: AppStyles.quranTextStyle30,
                  ),
                  Icon(
                    Icons.play_arrow,
                    color: AppColors.whiteColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
