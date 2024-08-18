import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/styles.dart';
import '../../../controller/audio_palylist_controller.dart';
import '../../../controller/surah_controller.dart';
import '../../../utils/widgets/custom_text_field.dart';
import 'custom_appbar.dart';
import 'surah_item.dart';
import 'package:moben/utils/app_router.dart';
import 'package:moben/utils/size_config.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final SurahController surahController = Get.put(SurahController());
    AudioPlaylistController audioPlaylistController = Get.put(AudioPlaylistController());
    return Scrollbar(
      interactive: true,
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppbar(),
            (screenHeight(context) * 0.02).sh,
            CustomTextField(
              hint: '2'.tr,
              onChanged: (val) {
                surahController.searchSurahs(val);
              },
            ),
            Obx(
                  () {
                if (surahController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (surahController.filteredSurahs.isEmpty) {
                  return const Center(child: Text('لا توجد سورة بهذا الأسم',style: AppStyles.textStyle30,));
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: surahController.filteredSurahs.length,
                    itemBuilder: (context, index) {
                      final surah = surahController.filteredSurahs[index];
                      return SurahItem(
                        surahName: surah.name ?? 'Unknown',
                        isMakkia: surah.makkia == 1,
                        surahId: surah.id ?? 404,
                        onTap: () {
                          audioPlaylistController.playTrack(surah.id!-1);
                          Get.toNamed(AppRouter.playViewPath, arguments: surah);
                        },
                      );
                    },
                  );
                }
              },
            ),
            (screenHeight(context)*0.1).sh,
          ],
        ),
      ),
    );
  }
}
