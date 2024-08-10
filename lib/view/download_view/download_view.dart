import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../../utils/widgets/glow_background.dart';
import 'widgets/download_view_body.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {

    return GlowBackground(
      firstColor: AppColors.accentColor.withOpacity(0.35),
      bottomPosition: -screenHeight(context) * 0.4,
      rightPosition: -screenWidth(context) * 0.9,
      child: const DownloadViewBody(),
    );
  }
}

