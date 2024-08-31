import 'package:flutter/cupertino.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/widgets/glass_circle.dart';

class AudioControllerWidget extends StatelessWidget {
  const AudioControllerWidget({
    super.key, required this.playOrPause, required this.next, required this.previous, required this.isPaused,
  });
  final Function() playOrPause;
  final Function() next;
  final Function() previous;
  final bool isPaused;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GlassCircle(
          height: screenHeight(context) * 0.06,
          width: screenWidth(context) * 0.2,
          onTap: next,
          child: const Icon(
            CupertinoIcons.arrowtriangle_right_fill,
            color: AppColors.accentColor,
            size: 30,
          ),
        ),
        GlassCircle(
          height: screenHeight(context) * 0.09,
          width: screenWidth(context) * 0.25,
          onTap: playOrPause,
          child:  Icon(
            isPaused ? CupertinoIcons.pause_solid : CupertinoIcons.play_arrow_solid,
            color: AppColors.accentColor,
            size: 45,
          ),
        ),
        GlassCircle(
          height: screenHeight(context) * 0.06,
          width: screenWidth(context) * 0.2,
          onTap: previous,
          child: const Icon(
            CupertinoIcons.arrowtriangle_left_fill,
            color: AppColors.accentColor,
            size: 30,
          ),
        ),
      ],
    );
  }
}
