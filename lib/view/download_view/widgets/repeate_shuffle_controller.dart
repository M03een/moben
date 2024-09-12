import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:just_audio/just_audio.dart';

import '../../../controller/audio_palylist_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';

class RepeatShuffleControls extends StatelessWidget {
  final AudioPlaylistController audioPlaylistController =
  Get.find<AudioPlaylistController>();

  RepeatShuffleControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: screenWidth(context)*0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              audioPlaylistController.cycleRepeatMode();
            },
            icon: Obx(() => Icon(
              audioPlaylistController.repeatMode.value == LoopMode.one
                  ? HugeIcons.strokeRoundedRepeatOne01
                  : HugeIcons.strokeRoundedRepeat,
              color: audioPlaylistController.repeatMode.value != LoopMode.off
                  ? AppColors.accentColor
                  : AppColors.whiteColor,
              size: 30,
            )),
          ),

          IconButton(
            onPressed: () {
              audioPlaylistController.toggleShuffle();
            },
            icon: Obx(() => Icon(
              HugeIcons.strokeRoundedShuffle,
              color: audioPlaylistController.isShuffle.value
                  ? AppColors.accentColor
                  : AppColors.whiteColor,
              size: 30,
            )),
          ),
        ],
      ),
    );
  }
}
