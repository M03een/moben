import 'package:flutter/material.dart';
import 'package:moben/utils/widgets/text_filling_loader.dart';
import 'package:moben/view/play_view/widgets/audio_controller.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../../utils/widgets/glow_container.dart';
import 'widgets/play_view_appbar.dart';
import 'widgets/reader_and_download_widget.dart';
import 'widgets/surah_widget.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlowContainer(
            color: AppColors.accentColor.withOpacity(0.35),
            bottomPosition: screenHeight(context) * 0.6,
            rightPosition: screenWidth(context) * -0.5,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth(context) * 0.05,
                screenHeight(context) * 0.04,
                screenWidth(context) * 0.05,
                0,
              ),
              child: Column(
                children: [
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
                  (screenHeight(context) * 0.01).sh,
                  
                  AudioController(
                    next: () {},
                    previous: () {},
                    pause: () {},
                  ),
                  (screenHeight(context)*0.02).sh,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
