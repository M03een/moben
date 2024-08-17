import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/surah_controller.dart';
import '../../../controller/audio_palylist_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';

class SurahBottomSheetBody extends StatelessWidget {
  final SurahController surahController = Get.put(SurahController());
  final AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());
  SurahBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: surahController.surahs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Obx(() {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextButton(
                      child: Text(
                        surahController.surahs[index].name!,
                        style: AppStyles.quranTextStyle30,
                      ),
                      onPressed: () {
                        audioPlaylistController.changeSurahAndPlay(index);
                        Get.back();
                      },
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor.withOpacity(0.3),
                    thickness: 1,
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
