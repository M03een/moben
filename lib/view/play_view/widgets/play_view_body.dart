import 'package:flutter/material.dart';
import 'package:moben/utils/widgets/text_filling_loader.dart';
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
    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth(context) * 0.05,
        screenHeight(context) * 0.04,
        screenWidth(context) * 0.05,
        0,
      ),
      child: Column(

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
          Spacer(),
          const AudioTimeLine(),
          AudioController(
            next: () {},
            previous: () {},
            pause: () {},
          ),
          (screenHeight(context) * 0.02).sh,
        ],
      ),
    );
  }
}
