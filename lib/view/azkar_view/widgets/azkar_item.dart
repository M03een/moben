import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/azkar_controller.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/glass_container.dart';

class AzkarrItem extends GetView<AzkarController> {
  const AzkarrItem({
    super.key,
    required this.zekrCategory,
    required this.imageUrl,
  });

  final String zekrCategory;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      onTap: () {
        controller.selectCategory(zekrCategory);
        Get.toNamed(AppRouter.zekrViewPath);
      },
      height: screenHeight(context) * 0.3,
      width: screenWidth(context) * 0.9,
      virMargin: screenWidth(context) * 0.02,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight(context) * 0.03,
          horizontal: screenWidth(context) * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imageUrl,
              height: screenHeight(context) * 0.15,
              width: screenWidth(context) * 0.3,
              fit: BoxFit.contain,
            ),
          Text(
              zekrCategory,
              style: AppStyles.textStyle27,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}