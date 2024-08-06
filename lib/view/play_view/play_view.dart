import 'package:flutter/material.dart';
import 'package:moben/view/play_view/widgets/play_view_body.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../../utils/widgets/glow_container.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlowContainer(
            color: AppColors.accentColor.withOpacity(0.35),
            bottomPosition: screenHeight(context) * 0.6,
            rightPosition: screenWidth(context) * -0.5,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: PlayViewBody(),
          )
        ],
      ),
    );
  }
}

