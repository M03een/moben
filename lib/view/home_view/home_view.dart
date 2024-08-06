import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/widgets/glow_background.dart';
import 'package:moben/view/home_view/widgets/home_view_body.dart';

import '../../utils/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      color: AppColors.accentColor.withOpacity(0.35),
      bottomPosition: screenHeight(context) * 0.4,
      rightPosition: screenWidth(context) * 0.1,
      child: const HomeViewBody(),
    );

  }
}
