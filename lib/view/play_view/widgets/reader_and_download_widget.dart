import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/audio_palylist_controller.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/view/play_view/widgets/reader_bottom_sheet_body.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_bottom_sheet.dart';
import '../../../core/utils/widgets/glass_container.dart';
import '../../../core/utils/widgets/snack_bars.dart';

class ReaderAndDownloadWidget extends StatelessWidget {
  ReaderAndDownloadWidget({
    super.key,
  });

  final ReaderController readerController = Get.put(ReaderController());
  final AudioPlaylistController audioPlaylistController = Get.put(
      AudioPlaylistController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GlassContainer(
          horMargin: 5,
          height: screenHeight(context) * 0.15,
          width: screenWidth(context) * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.person_fill,
                      color: AppColors.accentColor,
                      size: 25,
                    ),
                    Text(
                      'القارئ',
                      style: AppStyles.textStyle19
                          .copyWith(color: AppColors.accentColor),
                    )
                  ],
                ),
                const Spacer(),
                Obx(() {
                  return Row(
                    children: [
                      Text(
                        readerController.selectedReader.value,
                        style: AppStyles.textStyle15.copyWith(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {
                          showReaderBottomSheet(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.chevron_compact_down,
                          color: AppColors.accentColor,
                          size: 25,
                        ),
                      )
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              // Handle download button click
              if (audioPlaylistController.downloadStatus.value == 'download') {
                audioPlaylistController.downloadSurah(
                    audioPlaylistController.surahIndex.value);
              }
            },
            child: Obx(() {
              return GlassContainer(
                height: screenHeight(context) * 0.15,
                width: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: audioPlaylistController.isDownloading.value
                            ? (screenHeight(context) * 0.15) *
                            audioPlaylistController.downloadProgress.value
                            : screenHeight(context) * 0.15,
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.accentColor,
                              AppColors.secAccentColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (audioPlaylistController.isDownloading.value)
                              Text(
                                'تحميل... ${((audioPlaylistController
                                    .downloadProgress.value) * 100)
                                    .toStringAsFixed(0)}%',
                                style: AppStyles.textStyle15.copyWith(
                                    color: AppColors.primaryColor),
                              )
                            else
                              if (audioPlaylistController.downloadStatus
                                  .value == 'downloaded')
                                Text(
                                  'تم التحميل',
                                  style: AppStyles.textStyle19.copyWith(
                                      color: AppColors.primaryColor),
                                )
                              else
                                Column(
                                  children: [
                                    Text(
                                      'تحميل',
                                      style: AppStyles.textStyle19.copyWith(
                                          color: AppColors.primaryColor),
                                    ),
                                    const Icon(
                                      CupertinoIcons.down_arrow,
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        )

      ],
    );
  }

  void showReaderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      context: context,
      builder: (context) =>
          CustomBottomSheet(
            child: ReaderBottomSheetBody(),
          ),
    );
  }
}
