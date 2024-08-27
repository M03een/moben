/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/custom_icon.dart';

import '../../../controller/audio_palylist_controller.dart';
import '../../../utils/size_config.dart';
import '../../../utils/widgets/glass_container.dart';

class CustomBottomNavBar extends StatelessWidget {
    CustomBottomNavBar({
    super.key,
  });

  AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());


  @override
  Widget build(BuildContext context) {
    return Obx((){

      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GlassContainer(
              color: AppColors.primaryColor,
              horizontalPadding: screenWidth(context)*0.02,
              verticalPadding: 0,
              height: screenHeight(context) * 0.12,
              width: screenWidth(context) * 0.48,
              align: Alignment.center,
              borderRadius: 25,
              border: Border.all(color: AppColors.whiteColor.withOpacity(0.2),width: 0.5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        audioPlaylistController.surahName.value,
                        style: AppStyles.quranTextStyle30,
                      ),
                      audioPlaylistController.isPlay.value
                          ? IconButton(
                          onPressed: () {
                            audioPlaylistController.pause();
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: AppColors.whiteColor,
                          ))
                          : IconButton(
                          onPressed: () {
                            audioPlaylistController.play();
                          },
                          icon: const Icon(Icons.play_arrow,
                              color: AppColors.whiteColor)),
                    ],
                  ),
                  (screenHeight(context)*0.005).sh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIcon(
                        icon: 'waveform.svg',
                        onTap: () {},
                        isSelected: true,
                        color: AppColors.secAccentColor,
                      ),CustomIcon(
                        icon: 'bell-concierge.svg',
                        onTap: () {},
                        color: AppColors.secAccentColor,
                        isSelected: false,

                      ),CustomIcon(
                        icon: 'navigation.svg',
                        onTap: () {},
                        color: AppColors.secAccentColor,
                        isSelected: false,
                      ),CustomIcon(
                        icon: 'layers.svg',
                        onTap: () {},
                        color: AppColors.secAccentColor,
                        isSelected: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    });
  }
}


/*



 */


 */