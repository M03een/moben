import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/custom_icon.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';
import 'package:moben/core/utils/widgets/glow_background.dart';
import 'package:moben/view/download_view/widgets/downloaded_surah_view_body.dart';

class DownloadedSurahView extends StatelessWidget {
  final ReaderController readerController = Get.put(ReaderController());

  DownloadedSurahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowBackground(
        firstColor: AppColors.accentColor.withOpacity(0.35),
        secColor: AppColors.accentColor.withOpacity(0.35),
        bottomPosition: screenHeight(context) * 0.6,
        rightPosition: screenWidth(context) * -0.5,
        secRightPosition: -(screenWidth(context) * 0.8),
        tPadding: screenHeight(context) * 0.05,
        isAnimating: true,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
              child: Row(
                children: [
                  Text(
                    'التحميلات',
                    style: AppStyles.textStyle24.copyWith(
                      color: AppColors.accentColor,
                    ),
                  ),
                  Spacer(),
                  SvgIconButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: 'left_arrow.svg',
                    color: AppColors.accentColor,
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
                      readerController.setDownloadSelectedReader(
                          newIndex: index);
                      Get.to(() => DownloadedSurahsViewBody());
                    },
                    height: screenHeight(context) * 0.12,
                    width: screenWidth(context) * 0.8,
                    virMargin: screenHeight(context) * 0.01,
                    verticalPadding: screenHeight(context) * 0.005,
                    horizontalPadding: screenWidth(context) * 0.03,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            readerController.downloadReaderPics[index],
                          ),
                          radius: screenWidth(context) * 0.1,
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
        ),
      ),
    );
  }
}

/*
Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  readerController.downloadReaderNames[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
 */
