import 'package:flutter/material.dart';

import 'package:moben/view/play_view/widgets/play_view_body.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/size_config.dart';
import '../../core/utils/widgets/glow_background.dart';

class PlayView extends StatelessWidget {
   const PlayView({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GlowBackground(
        firstColor: AppColors.accentColor.withOpacity(0.35),
        secColor: AppColors.secAccentColor.withOpacity(0.35),
        bottomPosition: screenHeight(context) * 0.6,
        rightPosition: screenWidth(context) * -0.5,
        secRightPosition: -(screenWidth(context)*0.8),
        tPadding: screenHeight(context) * 0.05,
        isAnimating: true,
        child: PlayViewBody(),
      ),
    );
  }
}
