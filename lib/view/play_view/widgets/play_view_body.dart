import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/audio_controller.dart';
import 'package:moben/view/play_view/widgets/play_view_appbar.dart';
import 'package:moben/view/play_view/widgets/reader_and_download_widget.dart';
import 'package:moben/view/play_view/widgets/surah_widget.dart';

import '../../../controller/surah_controller.dart';
import '../../../model/surah_model.dart';
import '../../../utils/size_config.dart';
import 'audio_controller_widget.dart';
import 'audio_time_line.dart';

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
    return Column(
      children: [
        Obx(() {
          return PlayViewAppbar(
            surahName:
                '${surahController.surahs[audioController.surahIndex.value].name}' ??
                    'غير معلوم',
          );
        }),
        (screenHeight(context) * 0.02).sh,
        const ReaderAndDownloadWidget(
          readerName: 'ابوبكر الشاطري',
          isDownloaded: true,
          percentage: '',
        ),
        (screenHeight(context) * 0.01).sh,
        Obx(
            (){
              return SurahWidget(
                surahName: '${surahController.surahs[audioController.surahIndex.value].name}' ?? 'غير معلوم',
                isMakkia: surahController.surahs[audioController.surahIndex.value].makkia == 1,
              );
            }
        ),
        const Spacer(),
        const AudioTimeLine(),
        (screenHeight(context) * 0.04).sh,
        Obx(() {
          return AudioControllerWidget(
            isPaused: audioController.isPause.value,
            next: () {
              audioController.next(surahId: surahController.surahs[audioController.surahIndex.value].id! +1);
            },
            previous: () {
              audioController.previous(surahId:  surahController.surahs[audioController.surahIndex.value].id! -1 );
            },
            playOrPause: () {
              audioController.playOrPause(surahId: surahController.surahs[audioController.surahIndex.value].id!, readerId: 2);
            },
          );
        }),
        (screenHeight(context) * 0.02).sh,
      ],
    );
  }
}
