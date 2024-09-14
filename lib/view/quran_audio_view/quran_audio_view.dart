import 'package:flutter/material.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/glow_background.dart';
import '../../core/utils/colors.dart';
import 'widgets/quran_audio_view_body.dart';

class QuranAudioView extends StatelessWidget {
    const QuranAudioView({super.key});


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
            child: const QuranAudioViewBody(),

          ),
        ],
      ),
    );
  }
}


/*


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


 */