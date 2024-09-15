import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/all_download_manager.dart';
import 'package:moben/controller/audio_palylist_controller.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';

import '../../../controller/reader_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_icon.dart';

class DownloadedSurahViewBody extends StatelessWidget {
  DownloadedSurahViewBody({
    super.key,
  });

  final ReaderController readerController = Get.put(ReaderController());
  final AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());
  final DownloadManager downloadManagerController = Get.put(DownloadManager());

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery
        .of(context)
        .size
        .width >= 600;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
          child: Row(
            children: [
              Text(
                'التحميلات',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.accentColor,
                ),
              ),
              const Spacer(),
              Visibility(
                visible: !isTablet,
                child: SvgIconButton(
                  onTap: () {
                    Get.back();
                    downloadManagerController.resetDownloads();
                  },
                  icon: 'left_arrow.svg',
                  color: AppColors.accentColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: readerController.downloadReaderNames.length,
            itemBuilder: (context, index) {
              return GlassContainer(
                onTap: () {
                  readerController.setDownloadSelectedReader(newIndex: index);
                  audioPlaylistController.refreshDownloadedSurahs(
                    readerName: readerController.downloadReaderNames[index],
                  );
                  audioPlaylistController.stop();
                  readerController.downloadReaderIndex = index.obs;
                  Get.toNamed(AppRouter.readerDownloadedListPath);
                },
                height: screenHeight(context) * 0.12,
                width: screenWidth(context) * 0.8,
                virMargin: screenHeight(context) * 0.01,
                verticalPadding: screenHeight(context) * 0.005,
                horizontalPadding: screenWidth(context) * 0.03,
                child: Row(
                  children: [

                    Container(
                      width: screenWidth(context) * 0.1,
                      height: screenWidth(context) * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(readerController.downloadReaderPics[index]))
                      ),
                    ),
                    (screenWidth(context)*0.1).sw,
                    Text(
                      readerController.downloadReaderNames[index],
                      style: AppStyles.textStyle27,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
