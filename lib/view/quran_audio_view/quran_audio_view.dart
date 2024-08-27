import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/glow_background.dart';
import 'package:moben/view/quran_audio_view/widgets/custom_bottom_nav_bar.dart';
import '../../controller/surah_controller.dart';
import '../../controller/network_controller.dart'; // Import the NetworkController
import '../../utils/colors.dart';
import 'widgets/quran_audio_view_body.dart';

class QuranAudioView extends StatelessWidget {
  QuranAudioView({super.key});

  final SurahController surahController = Get.put(SurahController());
  final NetworkController networkController = Get.put(NetworkController());

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
            child: Obx(
              () {
                if (networkController.isInternetConnected.value) {
                  return const QuranAudioViewBody();
                } else {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.wifi_slash,
                        color: AppColors.accentColor,
                        size: 200,
                      ),
                      Text(
                        'لا يتوفر إتصال بالإنترنت',
                        style: AppStyles.textStyle24,
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
