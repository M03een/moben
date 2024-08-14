import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/reader_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';

class ReaderBottomSheetBody extends StatelessWidget {
  final ReaderController controller = Get.put(ReaderController());
    ReaderBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: controller.readerNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.setSelectedReader(newIndex: index);
              Get.back();
            },
            child: Obx(() {
              bool isSelected = controller.isSelected(index);
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(color: AppColors.accentColor, width: 3.0)
                          : null,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/images/readers/reader_${index + 1}.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  (screenHeight(context) * 0.01).sh,
                  Text(
                    controller.readerNames[index],
                    style: AppStyles.textStyle15.copyWith(
                      color: isSelected
                          ? AppColors.accentColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}


