import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';
import 'package:moben/core/utils/widgets/glow_background.dart';

import '../../../controller/donloaded_shurahs_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_icon.dart';
import 'downloaded_surah_player_view.dart';

class DownloadedSurahsViewBody extends StatelessWidget {
  DownloadedSurahsViewBody({super.key});

  final DownloadedSurahsController controller =
      Get.put(DownloadedSurahsController());

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
        // Changed from negative value to 0
        child: Column(
          children: [
            (screenHeight(context) * 0.04).sh,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
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
                            // Adjusted height
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
                                    Get.to(() =>  DownloadedSurahsPlayerView());
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
