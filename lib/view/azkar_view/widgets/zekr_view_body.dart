import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';
import 'package:moben/view/azkar_view/widgets/progress_bar.dart';
import 'package:moben/view/azkar_view/widgets/zekr_container.dart';

import '../../../controller/azkar_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class ZekrViewBody extends GetView<AzkarController> {
  const ZekrViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          (screenHeight(context) * 0.06).sh,
          Obx(
                () => GradientText(
              text: controller.selectedCategory.value?.name ?? '',
              gradient: const LinearGradient(colors: [
                AppColors.accentColor,
                AppColors.secAccentColor,
              ]),
              style: AppStyles.textStyle35,
            ),
          ),
          (screenHeight(context) * 0.00).sh,
          Obx(() {
            final category = controller.selectedCategory.value;
            if (category == null) {
              return const Center(child: Text('لم يتم اختيار اي ذكر'));
            }
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.items.length,
                controller: controller.scrollController,
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                            () {
                          final currentCount = controller.currentCounts[
                          '${category.name}_${item.content}']
                              ?.value ??
                              0;
                          final isFinished = controller.isZekrFinished(
                              category.name, item.content);
                          return ZekrContainer(
                            onTap: () {
                              controller.incrementCount(
                                  category.name, item.content,context);
                              if (isFinished) {
                                controller.scrollToNextIndex(index + 1, context);
                              }
                            },
                            zekr: item.content,
                            finishedCount: currentCount,
                            totalCount: item.count,
                            isZekrFinished: isFinished,
                          );
                        },
                      ),
                      SizedBox(
                        width:screenWidth(context) * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            maxLines: 3,
                            item.description,
                            style: AppStyles.textStyle15,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
          const ProgressBar(),
        ],
      ),
    );
  }
}

