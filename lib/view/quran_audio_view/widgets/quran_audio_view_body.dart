import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/styles.dart';
import '../../../controller/audio_palylist_controller.dart';
import '../../../controller/surah_controller.dart';
import '../../../model/surah_model.dart';
import '../../../utils/widgets/custom_text_field.dart';
import 'custom_appbar.dart';
import 'surah_item.dart';
import 'package:moben/utils/app_router.dart';
import 'package:moben/utils/size_config.dart';

class QuranAudioViewBody extends StatelessWidget {
  const QuranAudioViewBody({super.key});

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
                    child: Text('Error fetching Surahs', style: AppStyles.textStyle35),
                  );
                } else if (surahController.surahs.isEmpty) {
                  return const Center(
                    child: Text('لا توجد سورة بهذا الأسم', style: AppStyles.textStyle35),
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
                          audioPlaylistController.playTrack(surah.id! - 1);
                          Get.toNamed(AppRouter.playViewPath, arguments: surah);
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
    );
  }
}
