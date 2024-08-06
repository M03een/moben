import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/audio_controller.dart';
import 'package:moben/utils/surah_audio_id_generation.dart';
import 'package:moben/view/play_view/widgets/play_view_appbar.dart';
import 'package:moben/view/play_view/widgets/reader_and_download_widget.dart';
import 'package:moben/view/play_view/widgets/surah_widget.dart';

import '../../../model/surah_model.dart';
import '../../../utils/size_config.dart';
import 'audio_controller.dart';
import 'audio_time_line.dart';

class PlayViewBody extends StatelessWidget {
  const PlayViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Surah surah = Get.arguments ;
    final AudioController audioController = Get.put(AudioController());
    return Column(
      children:[
         PlayViewAppbar(
          surahName: surah.name ?? 'غير معلوم',
        ),
        (screenHeight(context) * 0.02).sh,
        const ReaderAndDownloadWidget(
          readerName: 'ابوبكر الشاطري',
          isDownloaded: true,
          percentage: '',
        ),
        (screenHeight(context) * 0.01).sh,
         SurahWidget(
          surahName: surah.name ?? 'غير معلوم',
          isMakkia: surah.makkia == 1,
        ),
        const Spacer(),
        const AudioTimeLine(),
        (screenHeight(context) * 0.04).sh,
        Obx((){
          return  AudioControllerWidget(
            isPaused: audioController.isPause.value,
            next: () {
              audioController.next(surahId: surah.id!);
            },
            previous: () {
              audioController.previous(surahId: surah.id!);
            },
            playOrPause: () {
              audioController.playOrPause(surahId: surah.id!,readerId: 2);
            },
          );
        }),

        (screenHeight(context) * 0.02).sh,
      ],
    );
  }
}
