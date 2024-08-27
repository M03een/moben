import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/view/counter_view/counter_view.dart';
import 'package:moben/view/qiblah_view/qiblah_view.dart';
import 'package:moben/view/quran_audio_view/widgets/custom_bottom_nav_bar.dart';

import '../../../controller/bottom_nav_controller.dart';
import '../quran_audio_view.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    QuranAudioView(),
    const CounterView(),
    const QiblahView(),
    const Center(
        child: Text(
      "Home 4",
      style: TextStyle(color: Colors.red, fontSize: 50),
    )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx((){

        return  Stack(
          children: [
            pages[controller.currentSelectedIndex.value],

            const Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavBar(),
            ),
          ],
        );

      }),

    );
  }
}

