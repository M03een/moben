import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/view/azkar_view/azkar_view.dart';
import 'package:moben/view/counter_view/counter_view.dart';
import 'package:moben/view/download_view/downloaded_surah_view.dart';
import 'package:moben/view/generate_image_view/views/all_images_view.dart';
import 'package:moben/view/notifications_manger_view/notification_manager_view.dart';
import 'package:moben/view/qiblah_view/qiblah_view.dart';
import 'package:moben/view/quran_audio_view/widgets/custom_bottom_nav_bar.dart';
import 'package:moben/view/quran_audio_view/widgets/custom_drawer.dart';
import 'package:moben/view/quran_audio_view/widgets/vertical_nav_bar.dart';

import '../../../controller/bottom_nav_controller.dart';
import '../../pray_view/pray_view.dart';
import '../quran_audio_view.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final BottomNavController controller = Get.put(BottomNavController());
  final SurahController surahController = Get.put(SurahController());

  final List<Widget> pages = [
    const QuranAudioView(),
    const CounterView(),
    const QiblahView(),
    const PrayView(),
    const AzkarView(),
    const DownloadedSurahView(),
    const NotificationManagerView(),
    AllImagesView()
  ];

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery
        .of(context)
        .size
        .width >= 600;

    return Scaffold(
      key: surahController.key,
      endDrawer: const CustomDrawer(),
      body: Obx(() {
        return Stack(
          children: [
            pages[controller.currentSelectedIndex.value],
            Obx(() {
              if (controller.isBottomNavBarVisible.value) {
                return isTablet
                    ? VerticalNavBar()
                    : CustomBottomNavBar();
              } else {
                return const SizedBox.shrink(); // Empty widget when hidden
              }
            }),
          ],
        );
      }),
    );
  }
}


