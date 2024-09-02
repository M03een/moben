import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/mesh.dart';
import 'package:moben/controller/counter_controller.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';

import 'mesh.dart';

class CounterViewBody extends StatelessWidget {
  const CounterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OMeshGradient(
          mesh: meshRect,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight(context) * 0.1),
            child: Column(
              children: [
                Text(
                  'المسبحة',
                  style: AppStyles.quranTextStyle50
                      .copyWith(color: AppColors.primaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info,
                      color: AppColors.primaryColor,
                    ),
                    Text(
                      'إضغط مطولا للإعادة ',
                      style: AppStyles.textStyle19.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: GetBuilder(
              init: CounterController(),
              builder: (value) {
                return InkWell(
                  onTap: () {
                    value.increment();
                  },
                  onLongPress: () {
                    value.reset();
                  },
                  child: AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 300),
                    textStyle: TextStyle(
                      fontSize: value.counter > 99 ? 250 : 300,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    value: value.counter,
                  ),
                );
              },
            )),
      ],
    );
  }
}
