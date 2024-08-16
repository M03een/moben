import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/audio_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/glass_container.dart';

class AutoPlay extends StatelessWidget {
  final AudioController audioController = Get.put(AudioController());

   AutoPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(

      height: screenHeight(context) * 0.15,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GlassContainer(
              onTap: () {
                audioController.repeatSurah.toggle();
                if (audioController.repeatSurah.value) {
                  audioController.shuffle.value = false;
                  audioController.repeatAll.value = false;
                }
              },
              height: screenHeight(context) * 0.15,
              width: 10,
              virMargin: 10,
              horMargin: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Icon(
                    CupertinoIcons.repeat_1,
                    color: audioController.repeatSurah.value
                        ? AppColors.accentColor
                        : AppColors.whiteColor,
                    size: 30,
                  )),
                  Text(
                    'تكرار السورة',
                    style: AppStyles.textStyle19.copyWith(
                      color: audioController.repeatSurah.value
                          ? AppColors.accentColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GlassContainer(
              onTap: () {
                audioController.shuffle.toggle(); // Toggle shuffle
                if (audioController.shuffle.value) {
                  audioController.repeatSurah.value = false;
                  audioController.repeatAll.value = false;
                }
              },
              height: screenHeight(context) * 0.15,
              width: 10,
              virMargin: 10,
              horMargin: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Icon(
                    CupertinoIcons.shuffle,
                    color: audioController.shuffle.value
                        ? AppColors.accentColor
                        : AppColors.whiteColor,
                    size: 30,
                  )),
                  Text(
                    'عشوائي',
                    style: AppStyles.textStyle19.copyWith(
                      color: audioController.shuffle.value
                          ? AppColors.accentColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GlassContainer(
              onTap: () {
                audioController.repeatAll.toggle(); // Toggle repeatAll
                if (audioController.repeatAll.value) {
                  audioController.shuffle.value = false;
                  audioController.repeatSurah.value = false;
                }
              },
              height: screenHeight(context) * 0.15,
              width: 10,
              virMargin: 10,
              horMargin: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Icon(
                    CupertinoIcons.repeat,
                    color: audioController.repeatAll.value
                        ? AppColors.accentColor
                        : AppColors.whiteColor,
                    size: 30,
                  )),
                  Text(
                    'تكرار الكل',
                    style: AppStyles.textStyle19.copyWith(
                      color: audioController.repeatAll.value
                          ? AppColors.accentColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
