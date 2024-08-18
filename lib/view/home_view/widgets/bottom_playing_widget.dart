import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/audio_controller.dart';
import 'package:moben/controller/audio_palylist_controller.dart';
import 'package:moben/utils/colors.dart';

import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/glass_container.dart';

class BottomPlayingWidget extends StatelessWidget {
  BottomPlayingWidget({
    super.key,
  });

  AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GlassContainer(
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 2
              ),
              color: Colors.transparent,
              horizontalPadding: 10,
              height: screenHeight(context)*0.07,
              width: screenWidth(context) * 0.9,
              align: Alignment.center,
              child: Row(
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
            ),
            (screenHeight(context)*0.02).sh,
          ],
        ),
      );
    });
  }
}
