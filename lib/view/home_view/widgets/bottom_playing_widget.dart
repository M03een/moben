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

  //AudioController audioController = Get.put(AudioController());
  AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Align(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                audioPlaylistController.surahName.value,
                // This will display the Surah name
                style: AppStyles.quranTextStyle30,
              ),
              audioPlaylistController.isPlay.value
                  ? IconButton(
                      onPressed: () {
                       // audioController.pause();
                      },
                      icon: const Icon(
                        Icons.pause,
                        color: AppColors.whiteColor,
                      ))
                  : IconButton(
                      onPressed: () {
                       // audioController.play();
                      },
                      icon: const Icon(Icons.play_arrow,
                          color: AppColors.whiteColor)),
            ],
          ),
        ),
      );
    });
  }
}
