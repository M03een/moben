import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/mesh.dart';
import 'package:moben/controller/counter_controller.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';

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
            child: const Text(
              'المسبحة',
              style: AppStyles.quranTextStyle50,
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
                  child: Text(
                    '${value.counter}',
                    style: const TextStyle(
                        fontSize: 300,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  ),
                );
              },
            )),
      ],
    );
  }
}
