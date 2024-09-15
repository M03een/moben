import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/view/download_view/widgets/repeate_shuffle_controller.dart';

import '../../../controller/audio_palylist_controller.dart';
import '../../../controller/surah_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/helper.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/glow_background.dart';
import '../../play_view/widgets/audio_controller_widget.dart';
import '../../play_view/widgets/audio_time_line.dart';

class DownloadedAudioPlayingView extends StatelessWidget {
  DownloadedAudioPlayingView({
    super.key,
  });

  final AudioPlaylistController controller = Get.put(AudioPlaylistController());
  final ReaderController readerController = Get.put(ReaderController());
  final SurahController surahController = Get.put(SurahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowBackground(
        rightPosition: screenWidth(context) * -0.5,
        bottomPosition: screenHeight(context) * 0.6,
        firstColor: AppColors.secAccentColor.withOpacity(0.35),
        secColor: AppColors.secAccentColor.withOpacity(0.35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: screenWidth(context) * 0.15,
                    height: screenHeight(context) * 0.06,
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowDown01,
                      color: AppColors.secAccentColor,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight(context) * 0.1),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: screenWidth(context) * 0.8,
                  height: screenHeight(context) * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(readerController.downloadReaderPics[
                            readerController.downloadReaderIndex.value]),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: screenHeight(context) * 0.07,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppColors.secAccentColor,
                      AppColors.accentColor
                    ])),
                    child: Obx(() {
                      return Text(
                        'controller.downloadedSurahName.value',
                        style: AppStyles.quranTextStyle30.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const Spacer(),
              RepeatShuffleControls(),
              Obx(
                () => AudioTimeLine(
                  onChanged: (value) {
                    controller.audioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  },
                  max: controller.duration.value.inSeconds.toDouble(),
                  value: controller.position.value.inSeconds.toDouble(),
                  totalDuration: HelperFunctions()
                      .formatDuration(controller.duration.value),
                  playedDuration: HelperFunctions()
                      .formatDuration(controller.position.value),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.04),
              Obx(() => AudioControllerWidget(
                    isPaused: controller.isPlay.value,
                    next: controller.nextDownloaded,
                    previous: controller.previousDownloaded,
                    playOrPause: () {
                      controller.isPlay.value
                          ? controller.pauseDownloaded()
                          : controller.resumeDownloaded();
                    },
                  )),
              SizedBox(height: screenHeight(context) * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
