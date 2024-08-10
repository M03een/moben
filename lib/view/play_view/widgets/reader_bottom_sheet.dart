import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';

import '../../../controller/reader_controller.dart';

class ReaderBottomSheet extends StatelessWidget {
  final ReaderController controller = Get.put(ReaderController());

  ReaderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.6,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth(context) * 0.18,
            height: screenHeight(context) * 0.008,
            decoration: BoxDecoration(
                color: AppColors.accentColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20)),
          ),
          (screenHeight(context) * 0.08).sh,
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
