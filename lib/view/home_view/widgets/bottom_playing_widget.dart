import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';

import '../../../controller/audio_controller.dart';
import '../../../controller/surah_controller.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/glass_container.dart';

class BottomPlayingWidget extends StatelessWidget {
  BottomPlayingWidget({
    super.key,
  });

  final AudioController audioController = Get.put(AudioController());
  final SurahController surahController = Get.put(SurahController());

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
                audioController.surahName.value, // This will display the Surah name
                style: AppStyles.quranTextStyle30,
              ),
              audioController.isPlay.value
                  ? IconButton(onPressed: () {}, icon: const Icon(Icons.pause,color: AppColors.whiteColor,))
                  : IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow,color: AppColors.whiteColor)),
            ],
          ),
        ),
      );
    });
  }
}
