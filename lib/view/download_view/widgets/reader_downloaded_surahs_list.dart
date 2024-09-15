import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/controller/network_controller.dart'; // Import the NetworkController
import '../../../controller/all_download_manager.dart';
import '../../../controller/audio_palylist_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_icon.dart';
import '../../../core/utils/widgets/glass_container.dart';
import '../../../core/utils/widgets/glow_background.dart';
import '../../../core/utils/widgets/gradient_text.dart';
import 'downloaded_surah_player_view.dart';

class ReaderDownloadedSurahsList extends StatelessWidget {
  ReaderDownloadedSurahsList({super.key});

  final AudioPlaylistController controller = Get.put(AudioPlaylistController());
  final ReaderController readerController = Get.put(ReaderController());
  final DownloadManager downloadManager = Get.put(DownloadManager());
  final NetworkController networkController = Get.put(NetworkController()); // Add NetworkController

  @override
  Widget build(BuildContext context) {
    controller.refreshDownloadedSurahs(
        readerName: readerController.selectedReader.value);
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
                    '${controller.downloadedReaderName}',
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
            (screenHeight(context) * 0.03).sh,

            Obx(() {
              if (downloadManager.isDownloading.value) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: downloadManager.currentDownloadingSurah.value / downloadManager.totalSurahs.value,
                      backgroundColor: AppColors.primaryColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secAccentColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'جاري التحميل: سورة ${downloadManager.currentDownloadingSurah.value} من ${downloadManager.totalSurahs.value}',
                      style: AppStyles.textStyle19,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        downloadManager.cancelDownload();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secAccentColor,
                      ),
                      child: Text('إلغاء التحميل', style: AppStyles.textStyle19.copyWith(color: AppColors.primaryColor)),
                    ),
                  ],
                );
              } else {
                return InkWell(
                  onTap: () {
                    // Check internet connection before starting download
                    if (networkController.isInternetConnected.value) {
                      downloadManager.downloadAllSurahs(readerController.downloadSelectedReader.value);
                    } else {
                      Get.snackbar(
                        'لا يوجد اتصال بالإنترنت',
                        'يرجى التأكد من اتصالك بالإنترنت للمواصلة',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight(context) * 0.01,
                      horizontal: screenWidth(context) * 0.05,
                    ),
                    width: double.infinity,
                    height: screenHeight(context) * 0.06,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.accentColor,
                          AppColors.secAccentColor
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'تحميل كل سور هذا المقرئ',
                      style: AppStyles.textStyle24.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }
            }),

            Obx(() {
              if (controller.downloadedSurahs.isEmpty) {
                return const Center(
                  child: GradientText(
                    text: 'لايوجد سور تم تحميلها لهذا المقرئ',
                    gradient: LinearGradient(
                      colors: [
                        AppColors.secAccentColor,
                        AppColors.accentColor
                      ],
                    ),
                    style: AppStyles.textStyle24,
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.downloadedSurahs.length,
                    itemBuilder: (context, index) {
                      final surahFile = controller.downloadedSurahs[index];
                      final surahName = controller.getSurahName(surahFile.path);
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
                                controller.playDownloaded(index);
                                Get.to(() => DownloadedAudioPlayingView());
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
              }
            }),
          ],
        ),
      ),
    );
  }
}
