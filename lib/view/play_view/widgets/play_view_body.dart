import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/helper.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';

import 'package:moben/view/play_view/widgets/play_view_appbar.dart';
import 'package:moben/view/play_view/widgets/reader_and_download_widget.dart';
import 'package:moben/view/play_view/widgets/surah_widget.dart';

import '../../../controller/audio_palylist_controller.dart';
import '../../../controller/surah_controller.dart';
import '../../../model/surah_model.dart';
import '../../../core/utils/size_config.dart';
import 'audio_controller_widget.dart';
import 'audio_time_line.dart';
import 'auto_play.dart';

class PlayViewBody extends StatelessWidget {
  PlayViewBody({
    super.key,
  });

  final SurahController surahController = Get.put(SurahController());
  final AudioPlaylistController audioPlaylistController =
      Get.put(AudioPlaylistController());

  @override
  Widget build(BuildContext context) {
    Surah surah = Get.arguments;
    audioPlaylistController.surahIndex.value = surah.id! - 1;
    return Obx(() {
      return Column(
        children: [
          PlayViewAppbar(
            surahName:
                '${surahController.surahs[audioPlaylistController.surahIndex.value].name}',
          ),
          (screenHeight(context) * 0.02).sh,
          ReaderAndDownloadWidget(

            downloadOnTap: () {
              MobenSnackBars().nextUpdateSnackBar();
            },
          ),
          (screenHeight(context) * 0.01).sh,
          SurahWidget(
            surahName:
                '${surahController.surahs[audioPlaylistController.surahIndex.value].name}',
            isMakkia: surahController
                    .surahs[audioPlaylistController.surahIndex.value].makkia ==
                1,
          ),
          (screenHeight(context) * 0.01).sh,
          AutoPlay(),
          const Spacer(),
          AudioTimeLine(
            onChanged: (value) {
              audioPlaylistController.audioPlayer
                  .seek(Duration(seconds: value.toInt()));
            },
            max: audioPlaylistController.duration.value.inSeconds.toDouble(),
            value: audioPlaylistController.position.value.inSeconds.toDouble(),
            totalDuration: HelperFunctions()
                .formatDuration(audioPlaylistController.duration.value),
            playedDuration: HelperFunctions()
                .formatDuration(audioPlaylistController.position.value),
          ),
          (screenHeight(context) * 0.04).sh,
          AudioControllerWidget(
            isPaused: audioPlaylistController.isPlay.value,
            next: () {
              audioPlaylistController.next();
            },
            previous: () {
              audioPlaylistController.previous();
            },
            playOrPause: () {
              audioPlaylistController.isPlay.value
                  ? audioPlaylistController.pause()
                  : audioPlaylistController.play();
            },
          ),
          (screenHeight(context) * 0.02).sh,
        ],
      );
    });
  }
}
