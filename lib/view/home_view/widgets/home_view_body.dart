import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/network_controller.dart';
import '../../../controller/audio_controller.dart';
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
    final AudioController audioController = Get.put(AudioController());
    final NetworkController networkController = Get.put(NetworkController());
    return SingleChildScrollView(
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
                        audioController.onlyPlay(surahId: surah.id!);
                        Get.toNamed(AppRouter.playViewPath, arguments: surah);
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
