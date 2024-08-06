import 'package:flutter/material.dart';
import 'package:moben/view/play_view/widgets/play_view_appbar.dart';
import 'package:moben/view/play_view/widgets/reader_and_download_widget.dart';
import 'package:moben/view/play_view/widgets/surah_widget.dart';

import '../../../utils/size_config.dart';
import 'audio_controller.dart';
import 'audio_time_line.dart';

class PlayViewBody extends StatelessWidget {
  const PlayViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        const PlayViewAppbar(
          surahName: 'الفاتحة',
        ),
        (screenHeight(context) * 0.02).sh,
        const ReaderAndDownloadWidget(
          readerName: 'ابوبكر الشاطري',
          isDownloaded: true,
          percentage: '',
        ),
        (screenHeight(context) * 0.01).sh,
        const SurahWidget(
          surahName: 'الفاتحة',
          isMakkia: true,
        ),
        const Spacer(),
        const AudioTimeLine(),
        (screenHeight(context) * 0.04).sh,
        AudioController(
          next: () {},
          previous: () {},
          pause: () {},
        ),
        (screenHeight(context) * 0.02).sh,
      ],
    );
  }
}
