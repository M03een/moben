import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/glow_background.dart';
import 'package:moben/view/home_view/widgets/bottom_playing_widget.dart';
import '../../controller/audio_controller.dart';
import '../../controller/surah_controller.dart';
import '../../controller/network_controller.dart'; // Import the NetworkController
import '../../utils/colors.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AudioController audioController = Get.put(AudioController());
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
            child: Obx(() {
              if (networkController.isInternetConnected.value) {
                return const HomeViewBody();
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
            }),
          ),
            BottomPlayingWidget(),
        ],
      ),
    );
  }
}

