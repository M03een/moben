import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/custom_icon.dart';
import '../../../controller/azkar_controller.dart';
import '../../../model/azkar_category.dart';
import 'azkar_item.dart';

class AzkarViewBody extends StatelessWidget {
  AzkarViewBody({super.key});

  final AzkarController controller = Get.put(AzkarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.06),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'أذكار',
                  style: AppStyles.textStyle35.copyWith(
                    color: AppColors.secAccentColor,
                  ),
                ),
                SvgIconButton(
                  onTap: () {
                    Get.back();
                  },
                  icon: 'left_arrow.svg',
                  color: AppColors.secAccentColor,
                ),
              ],
            ),
            (screenHeight(context) * 0.02).sh,
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.azkarCategories.isEmpty) {
                  return const Center(child: Text('لا تتوفر بيانات'));
                } else {
                  return ListView.builder(
                    itemCount: controller.azkarCategories.length,
                    itemBuilder: (context, index) {
                      String category =
                          controller.azkarCategories.keys.toList()[index];
                      AzkarCategory? azkarCategory =
                          controller.azkarCategories[category];
                      String imageUrl = azkarCategory?.imageUrl ??
                          'assets/images/default_azkar.png';
                      return AzkarrItem(
                        zekrCategory: category,
                        imageUrl: imageUrl,

                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
