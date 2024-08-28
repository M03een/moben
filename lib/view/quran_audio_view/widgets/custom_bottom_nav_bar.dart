import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/custom_icon.dart';
import '../../../controller/audio_palylist_controller.dart';
import '../../../controller/bottom_nav_controller.dart';
import '../../../utils/size_config.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  AudioPlaylistController audioPlaylistController =
      Get.put(AudioPlaylistController());

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(() {
          return Visibility(
            visible: audioPlaylistController.isPlay.value,
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColors.secAccentColor,
                    width: 0.5,
                  )),
              padding: EdgeInsets.only(right: screenWidth(context)*0.03),
              height: screenHeight(context) * 0.12,
              width: screenWidth(context) * 0.5,
              margin: EdgeInsets.only(bottom: screenHeight(context) * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    audioPlaylistController.surahName.value,
                    style: AppStyles.quranTextStyle30,
                  ),
                  Obx(() => audioPlaylistController.isPlay.value
                      ? IconButton(
                          onPressed: () {
                            audioPlaylistController.pause();
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: AppColors.whiteColor,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            audioPlaylistController.play();
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: AppColors.whiteColor,
                          ),
                        )),
                ],
              ),
            ),
          );
        }),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: AppColors.secAccentColor.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 10,
                    offset: const Offset(0, 5))
              ]),
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
          height: screenHeight(context) * 0.06,
          width: screenWidth(context) * 0.5,
          margin: EdgeInsets.only(bottom: screenHeight(context) * 0.03),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIcon(
                  icon: 'waveform.svg',
                  onTap: () {
                    controller.updateCurrentIndex(0);
                  },
                  isSelected: controller.currentSelectedIndex.value == 0,
                  color: controller.currentSelectedIndex.value == 0
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'bell-concierge.svg',
                  onTap: () {
                    controller.updateCurrentIndex(1);
                  },
                  isSelected: controller.currentSelectedIndex.value == 1,
                  color: controller.currentSelectedIndex.value == 1
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'navigation.svg',
                  onTap: () {
                    controller.updateCurrentIndex(2);
                  },
                  isSelected: controller.currentSelectedIndex.value == 2,
                  color: controller.currentSelectedIndex.value == 2
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'person-praying.svg',
                  onTap: () {
                    controller.updateCurrentIndex(3);
                  },
                  isSelected: controller.currentSelectedIndex.value == 3,
                  color: controller.currentSelectedIndex.value == 3
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
