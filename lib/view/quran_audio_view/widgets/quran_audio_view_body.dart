import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/styles.dart';
import '../../../controller/surah_controller.dart';
import '../../../model/surah_model.dart';
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

    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Scrollbar(
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
                      CustomTextField(
                        hint: '2'.tr,
                        obscureText: true,
                        onChanged: (val) {
                          surahController.searchSurahs(val);
                        },
                      ),
                      FutureBuilder<List<Surah>>(
                        future: Future.value(surahController.surahs),
                        builder: (context, snapshot) {
                          if (surahController.isLoading.value) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching Surahs',
                                  style: AppStyles.textStyle35),
                            );
                          } else if (surahController.surahs.isEmpty) {
                            return const Center(
                              child: Text('لا توجد سورة بهذا الأسم',
                                  style: AppStyles.textStyle35),
                            );
                          } else {
                            final surahs = surahController.surahs;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: surahs.length,
                              itemBuilder: (context, index) {
                                final surah = surahs[index];
                                return SurahItem(
                                  surahName: surah.name ?? 'Unknown',
                                  isMakkia: surah.makkia == 1,
                                  surahId: surah.id ?? 404,
                                  onTap: () {
                                    Get.toNamed(AppRouter.playViewPath,
                                        arguments: surah);
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                      (screenHeight(context) * 0.1).sh,
                    ],
                  ),
                ),
              ),
            ),
            (screenWidth(context) * 0.01).sw,
            // Vertical navigation bar
          ],
        ),
        // Positioned jump-to-top button
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
                      child: const HugeIcon(
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
