import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/widgets/gradient_text.dart';
import 'package:moben/view/azkar_view/widgets/progress_bar.dart';
import 'package:moben/view/azkar_view/widgets/zekr_container.dart';

import '../../../controller/azkar_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';

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
                 itemBuilder: (context, index){
                   final item = category.items[index];
                   return ZekrContainer(
                     onTap: () {},
                     finishedCount: 0,
                     totalCount: item.count,
                     child: Text(
                       item.content,
                       textAlign: TextAlign.center,
                       style: AppStyles.quranTextStyle30.copyWith(
                           color: AppColors.primaryColor,
                           height: 2,
                           fontWeight: FontWeight.bold),
                     ),
                   );
             }),
           );
          }),

          const ProgressBar(),
        ],
      ),
    );
  }
}

