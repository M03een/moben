import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/app_router.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/view/home_view/widgets/surah_item.dart';
import '../../../utils/widgets/custom_text_field.dart';
import 'custom_appbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomAppbar(),
          (screenHeight(context) * 0.02).sh,
          const CustomTextField(),
          (screenHeight(context) * 0.03).sh,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return SurahItem(
                surahName: 'الفاتحة',
                isMakkia: true,
                onTap: () {
                  Get.toNamed(AppRouter.playViewPath);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
