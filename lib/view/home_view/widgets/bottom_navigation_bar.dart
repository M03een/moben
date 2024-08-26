import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/view/home_view/quran_audio_view.dart';

import '../../../controller/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    QuranAudioView(),
    const Center(
        child: Text(
      "Home 2",
      style: TextStyle(color: Colors.red, fontSize: 50),
    )),
    const Center(
        child: Text(
      "Home 3",
      style: TextStyle(color: Colors.red, fontSize: 50),
    )),
    const Center(
        child: Text(
      "Home 4",
      style: TextStyle(color: Colors.red, fontSize: 50),
    )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentSelectedIndex.value]),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          onTap: controller.updateCurrentIndex,
          currentIndex: controller.currentSelectedIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            bottomNavigationBarItem(icon: 'waveform.svg', label: 'audio',color: ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            bottomNavigationBarItem(icon: 'bell-concierge.svg', label: 'audio',color: ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            bottomNavigationBarItem(icon: 'praying-hands.svg', label: 'audio',color: ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            bottomNavigationBarItem(icon: 'layers.svg', label: 'audio',color: ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),

          ],
        );
      }),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem(
      {required String icon, required String label ,required ColorFilter color}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/svg_icons/$icon',
        colorFilter: color,
      ),

      activeIcon: SvgPicture.asset(
        'assets/icons/svg_icons/$icon',
        colorFilter: const ColorFilter.mode(AppColors.secAccentColor, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}

Color inActiveIconColor = AppColors.whiteColor.withOpacity(0.4);
