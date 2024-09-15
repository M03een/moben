import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/styles.dart';
import '../../../controller/audio_palylist_controller.dart';
import '../../../controller/surah_controller.dart';
import '../../../controller/network_controller.dart'; // Import the NetworkController
import '../../../core/utils/widgets/custom_text_field.dart';
import 'custom_appbar.dart';
import 'surah_item.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/core/utils/size_config.dart';

class QuranAudioViewBody extends StatelessWidget {
  const QuranAudioViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final SurahController surahController = Get.put(SurahController());
    final AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());
    final AudioPlaylistController downloadedSurahsController = Get.put(AudioPlaylistController());
    final NetworkController networkController = Get.put(NetworkController()); // Add NetworkController

    return Stack(
      children: [
        Scrollbar(
          controller: surahController.scrollController,
          interactive: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: surahController.scrollController,
            primary: false,
            child: Column(
              children: [
                CustomAppbar(),
                (screenHeight(context) * 0.02).sh,

                // CustomTextField for search
                CustomTextField(
                  hint: 'ابحث عن السورة',
                  obscureText: false,
                  onChanged: (val) {
                    surahController.searchSurahs(val); // Trigger search
                  },
                ),
                Obx(() {
                  if (surahController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else if (surahController.filteredSurahs.isEmpty) {
                    return const Center(
                      child: Text('لم يتم إيجاد اي سور',
                          style: AppStyles.textStyle35),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: surahController.filteredSurahsLength,
                      itemBuilder: (context, index) {
                        final surah = surahController.filteredSurahs[index];
                        return SurahItem(
                          surahName: surah.name ?? 'Unknown',
                          isMakkia: surah.makkia == 1,
                          surahId: surah.id ?? 404,
                          onTap: () {
                            if (networkController.isInternetConnected.value) {
                              audioPlaylistController.playTrack(surah.id! - 1);
                              downloadedSurahsController.stopDownloaded();

                              Get.toNamed(AppRouter.playViewPath, arguments: surah);
                            } else {
                              Get.snackbar(
                                'No Internet Connection',
                                'Please check your connection to play the Surah',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                }),
                (screenHeight(context) * 0.1).sh,
              ],
            ),
          ),
        ),

        // Jump to Top Button
        Obx(() {
          return surahController.showJumpToTopButton.value
              ? Positioned(
            bottom: screenHeight(context) * 0.03,
            right: screenWidth(context) * 0.05,
            child: InkWell(
              onTap: () {
                surahController.scrollToTop();
              },
              child: Container(
                height: screenHeight(context) * 0.06,
                width: screenWidth(context) * 0.1,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secAccentColor.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]),
                child: const  HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowUp01,
                  color: AppColors.secAccentColor,
                ),
              ),
            ),
          )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}
