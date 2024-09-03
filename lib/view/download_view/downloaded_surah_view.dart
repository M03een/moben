import 'package:flutter/material.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/glow_background.dart';
import 'package:moben/view/download_view/widgets/downloaded_surah_view_body.dart';

class DownloadedSurahView extends StatelessWidget {


  const DownloadedSurahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowBackground(
        firstColor: AppColors.accentColor.withOpacity(0.35),
        secColor: AppColors.accentColor.withOpacity(0.35),
        bottomPosition: screenHeight(context) * 0.6,
        rightPosition: screenWidth(context) * -0.5,
        secRightPosition: -(screenWidth(context) * 0.8),
        tPadding: screenHeight(context) * 0.05,
        isAnimating: true,
        child:   DownloadedSurahViewBody(),
      ),
    );
  }
}


