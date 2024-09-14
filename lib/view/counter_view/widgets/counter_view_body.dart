import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/mesh.dart';
import 'package:moben/controller/counter_controller.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';

import 'inline_editable_text.dart';
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
        Column(
          children: [
            (screenHeight(context) * 0.06).sh,
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
            (screenHeight(context) * 0.03).sh,
            // New editable text field
            GetBuilder<CounterController>(
              init: CounterController(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InlineEditableText(
                    initialText: controller.customText.value,
                    onChanged: (newText) {
                      controller.updateCustomText(newText);
                    },
                    textStyle: AppStyles.quranTextStyle30.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),
            // Expanded area for tapping (covers the rest of the screen)
            Expanded(
              child: GetBuilder<CounterController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: controller.increment,
                    onLongPress: controller.reset,
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: AnimatedFlipCounter(
                        duration: const Duration(milliseconds: 300),
                        textStyle: TextStyle(
                          fontSize: controller.counter > 99 ? 250 : 300,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        value: controller.counter,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
