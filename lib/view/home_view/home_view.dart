import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/view/home_view/widgets/home_view_body.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/glow_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlowContainer(
            color: AppColors.accentColor.withOpacity(0.35),
            bottomPosition: screenHeight(context) * 0.4,
            rightPosition: screenWidth(context) * 0.1,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth(context) * 0.05,
                screenHeight(context) * 0.04,
                screenWidth(context) * 0.05,
                0,
              ),
              child: const HomeViewBody(),
            ),
          )
        ],
      ),
    );
  }
}
