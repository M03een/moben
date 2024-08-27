import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moben/utils/colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, required this.onTap, required this.color, required this.isSelected});
  final String icon;
  final Function() onTap;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColors.whiteColor.withOpacity(isSelected ? 0.1 : 0),
        child: SvgPicture.asset(
          'assets/icons/svg_icons/$icon',
          colorFilter:
            ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}
