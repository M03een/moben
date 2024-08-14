import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/audio_controller.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/helper.dart';

import 'package:moben/view/play_view/widgets/play_view_appbar.dart';
import 'package:moben/view/play_view/widgets/reader_and_download_widget.dart';
import 'package:moben/view/play_view/widgets/surah_widget.dart';

import '../../../controller/surah_controller.dart';
import '../../../model/surah_model.dart';
import '../../../utils/size_config.dart';
import 'audio_controller_widget.dart';
import 'audio_time_line.dart';
import 'auto_play.dart';

class PlayViewBody extends StatelessWidget {
  PlayViewBody({
    super.key,
  });

  final AudioController audioController = Get.put(AudioController());
  final SurahController surahController = Get.put(SurahController());

  @override
  Widget build(BuildContext context) {
    Surah surah = Get.arguments;
    audioController.surahIndex.value = surah.id! - 1;

    return Obx(() {
      return Column(
        children: [
          PlayViewAppbar(
            surahName:
                '${surahController.surahs[audioController.surahIndex.value].name}',
          ),
          (screenHeight(context) * 0.02).sh,
          ReaderAndDownloadWidget(
            readerName: 'ابوبكر الشاطري',
            isDownloaded: true,
            percentage: '',
            downloadOnTap: () {
              Get.snackbar(
                'هذه الخدمة غير متوفرة ',
                "ستتوفر هذة الميزة في التحديث القادم للتطبيق",
                colorText: Colors.white,
                backgroundColor: AppColors.primaryColor,
                icon: const Icon(
                  Icons.upcoming,
                  color: AppColors.accentColor,
                ),
                borderColor: AppColors.accentColor,
                borderWidth: 2,
              );
            },
          ),
          (screenHeight(context) * 0.01).sh,
          SurahWidget(
            surahName:
                '${surahController.surahs[audioController.surahIndex.value].name}',
            isMakkia: surahController
                    .surahs[audioController.surahIndex.value].makkia ==
                1,
          ),
          (screenHeight(context) * 0.01).sh,
           AutoPlay(),
          const Spacer(),
          audioController.loading.value
              ? const Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : AudioTimeLine(
                  onChanged: (value) {
                    audioController.audioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  },
                  max: audioController.duration.value.inSeconds.toDouble(),
                  value: audioController.position.value.inSeconds.toDouble(),
                  totalDuration: HelperFunctions()
                      .formatDuration(audioController.duration.value),
                  playedDuration: HelperFunctions()
                      .formatDuration(audioController.position.value),
                ),
          (screenHeight(context) * 0.04).sh,
          AudioControllerWidget(
            isPaused: audioController.isPlay.value,
            next: () {
              audioController.next(
                  surahId: surahController
                          .surahs[audioController.surahIndex.value].id! +
                      1);
            },
            previous: () {
              audioController.previous(
                  surahId: surahController
                          .surahs[audioController.surahIndex.value].id! -
                      1);
            },
            playOrPause: () {
              audioController.playOrPause(
                  surahId: surahController
                      .surahs[audioController.surahIndex.value].id!,
                  readerId: 2);
            },
          ),
          (screenHeight(context) * 0.02).sh,
        ],
      );
    });
  }
}


