 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:just_audio/just_audio.dart';

import '../../../controller/audio_palylist_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/glass_container.dart';

class AutoPlay extends StatelessWidget {
  final AudioPlaylistController audioPlaylistController =
      Get.find<AudioPlaylistController>();

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
                audioPlaylistController.cycleRepeatMode();
              },
              height: screenHeight(context) * 0.15,
              width: 10,
              virMargin: 10,
              horMargin: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Icon(
                        audioPlaylistController.repeatMode.value == LoopMode.one
                            ? CupertinoIcons.repeat_1
                            : CupertinoIcons.repeat,
                        color: audioPlaylistController.repeatMode.value !=
                                LoopMode.off
                            ? AppColors.accentColor
                            : AppColors.whiteColor,
                        size: 30,
                      )),
                  Obx(() => Text(
                        audioPlaylistController.repeatModeString,
                        style: AppStyles.textStyle19.copyWith(
                          color: audioPlaylistController.repeatMode.value !=
                                  LoopMode.off
                              ? AppColors.accentColor
                              : AppColors.whiteColor,
                        ),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: GlassContainer(
              onTap: () {
                audioPlaylistController.toggleShuffle();
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
                        color: audioPlaylistController.isShuffle.value
                            ? AppColors.accentColor
                            : AppColors.whiteColor,
                        size: 30,
                      )),
                  Text(
                    'عشوائي',
                    style: AppStyles.textStyle19.copyWith(
                      color: audioPlaylistController.isShuffle.value
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
