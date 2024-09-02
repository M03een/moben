import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/donloaded_shurahs_controller.dart';
import '../../../core/utils/styles.dart';

class DownloadedSurahsViewBody extends StatelessWidget {
  DownloadedSurahsViewBody({super.key});

  final DownloadedSurahsController controller =
      Get.put(DownloadedSurahsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Surahs - ${controller.readerName}'),
      ),
      body: Obx(() {
        return controller.downloadedSurahs.isEmpty
            ? const Center(child: Text('No downloaded Surahs'))
            : ListView.builder(
                itemCount: controller.downloadedSurahs.length,
                itemBuilder: (context, index) {
                  final surahFile = controller.downloadedSurahs[index];
                  final surahName =
                      surahFile.path.split('/').last.replaceAll('.mp3', '');

                  return ListTile(
                    title: Text(
                      surahName,
                      style: AppStyles.textStyle27,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        // Implement play audio logic here
                        print('Playing Surah: $surahName');
                      },
                    ),
                  );
                },
              );
      }),
    );
  }
}
