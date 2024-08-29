import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/widgets/gradient_text.dart';
import 'package:moben/view/azkar_view/widgets/progress_bar.dart';
import 'package:moben/view/azkar_view/widgets/zekr_counter.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import 'counter_text.dart';

class ZekrViewBody extends StatelessWidget {
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
          (screenHeight(context) * 0.05).sh,
          const GradientText(
            text: 'أذكار الصباح',
            gradient: LinearGradient(colors: [
              AppColors.accentColor,
              AppColors.secAccentColor,
            ]),
            style: AppStyles.textStyle40,
          ),
          (screenHeight(context) * 0.05).sh,
          ZekrContainer(
            onTap: (){},
            child: Text(
              textAlign: TextAlign.center,
              " أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قديرأَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير",
              style: AppStyles.quranTextStyle30.copyWith(
                  color: AppColors.primaryColor,
                  height: 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const ProgressBar(),
          const CountText()
        ],
      ),
    );
  }
}



