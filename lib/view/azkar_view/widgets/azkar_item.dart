import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/app_router.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/glass_container.dart';

class AzkarrItem extends StatelessWidget {
  const AzkarrItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      onTap: () {
        Get.toNamed(AppRouter.zekrViewPath);
      },
      height: screenHeight(context) * 0.26,
      width: screenWidth(context) * 0.9,
      virMargin: screenWidth(context) * 0.02,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/azkar_avatars/day.png'),
            const Text(
              'أذكار الصباح',
              style: AppStyles.textStyle35,
            )
          ],
        ),
      ),
    );
  }
}
