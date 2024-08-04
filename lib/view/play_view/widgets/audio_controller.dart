import 'package:flutter/cupertino.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/widgets/glass_circle.dart';

class AudioController extends StatelessWidget {
  const AudioController({
    super.key, required this.pause, required this.next, required this.previous,
  });
  final Function() pause;
  final Function() next;
  final Function() previous;

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
          onTap: pause,
          child: const Icon(
            CupertinoIcons.pause_solid,
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
