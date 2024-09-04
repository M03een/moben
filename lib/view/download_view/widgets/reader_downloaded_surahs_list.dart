import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../controller/downloaded_shurahs_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_icon.dart';
import '../../../core/utils/widgets/glass_container.dart';
import '../../../core/utils/widgets/glow_background.dart';

class ReaderDownloadedSurahsList extends StatelessWidget {
  ReaderDownloadedSurahsList({super.key});

  final DownloadedSurahsController controller = Get.put(DownloadedSurahsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowBackground(
        firstColor: AppColors.secAccentColor.withOpacity(0.35),
        secColor: AppColors.secAccentColor.withOpacity(0.35),
        bottomPosition: screenHeight(context) * 0.6,
        rightPosition: screenWidth(context) * -0.5,
        secRightPosition: -(screenWidth(context) * 0.8),
        tPadding: 0,
        child: Column(
          children: [
            (screenHeight(context) * 0.04).sh,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
              child: Row(
                children: [
                  Text(
                    '${controller.readerName}',
                    style: AppStyles.textStyle24.copyWith(
                      color: AppColors.secAccentColor,
                    ),
                  ),
                  const Spacer(),
                  SvgIconButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: 'left_arrow.svg',
                    color: AppColors.secAccentColor,
                  ),
                ],
              ),
            ),
            Obx(() {
              return controller.downloadedSurahs.isEmpty
                  ? const Center(child: Text('No downloaded Surahs'))
                  : Expanded(
                child: ListView.builder(
                  itemCount: controller.downloadedSurahs.length,
                  itemBuilder: (context, index) {
                    final surahFile = controller.downloadedSurahs[index];
                    final surahName = surahFile.path
                        .split('/')
                        .last
                        .replaceAll('.mp3', '');

                    return GlassContainer(
                      height: screenHeight(context) * 0.08,
                      width: screenWidth(context) * 0.8,
                      virMargin: screenHeight(context) * 0.01,
                      verticalPadding: screenHeight(context) * 0.005,
                      horizontalPadding: screenWidth(context) * 0.03,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            surahName,
                            style: AppStyles.textStyle19,
                          ),
                          IconButton(
                            onPressed: () {
                              controller.play(index);
                              Get.to(() => AudioPlayingView(
                                surahIndex: index,
                                surahName: surahName,
                              ));
                            },
                            icon: const Icon(
                              HugeIcons.strokeRoundedPlay,
                              color: AppColors.secAccentColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class AudioPlayingView extends StatelessWidget {
  final int surahIndex;
  final String surahName;

  AudioPlayingView({Key? key, required this.surahIndex, required this.surahName}) : super(key: key);

  final DownloadedSurahsController controller = Get.find<DownloadedSurahsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
        backgroundColor: AppColors.secAccentColor,
      ),
      body: GlowBackground(
        rightPosition: screenWidth(context) * -0.5,
        bottomPosition: screenHeight(context) * 0.6,
        firstColor: AppColors.secAccentColor.withOpacity(0.35),
        secColor: AppColors.secAccentColor.withOpacity(0.35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                surahName,
                style: AppStyles.textStyle24.copyWith(color: AppColors.secAccentColor),
              ),
              SizedBox(height: 30),
              Obx(() => Text(
                controller.isPlaying.value ? 'Playing' : 'Paused',
                style: AppStyles.textStyle19,
              )),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, size: 40),
                    onPressed: () {
                      if (surahIndex > 0) {
                        controller.play(surahIndex - 1);
                        Get.off(() => AudioPlayingView(
                          surahIndex: surahIndex - 1,
                          surahName: controller.downloadedSurahs[surahIndex - 1].path.split('/').last.replaceAll('.mp3', ''),
                        ));
                      }
                    },
                  ),
                  Obx(() => IconButton(
                    icon: Icon(
                      controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                      size: 60,
                    ),
                    onPressed: () {
                      if (controller.isPlaying.value) {
                        controller.pause();
                      } else {
                        controller.resume();
                      }
                    },
                  )),
                  IconButton(
                    icon: Icon(Icons.skip_next, size: 40),
                    onPressed: () {
                      if (surahIndex < controller.downloadedSurahs.length - 1) {
                        controller.play(surahIndex + 1);
                        Get.off(() => AudioPlayingView(
                          surahIndex: surahIndex + 1,
                          surahName: controller.downloadedSurahs[surahIndex + 1].path.split('/').last.replaceAll('.mp3', ''),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}