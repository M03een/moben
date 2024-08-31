import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moben/core/utils/colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, required this.onTap, required this.color, this.isSelected, this.width, this.height, });
  final String icon;
  final Function() onTap;
  final Color color;
  final bool? isSelected;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.whiteColor.withOpacity(isSelected ?? true ? 0.1 : 0),
      child: SvgIconButton(onTap: onTap, width: width, height: height, icon: icon, color: color),
    );
  }
}

class SvgIconButton extends StatelessWidget {
  const SvgIconButton({
    super.key,
    required this.onTap,

    required this.icon,
    required this.color, this.width, this.height,
  });

  final Function() onTap;
  final double? width;
  final double? height;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        fit: BoxFit.cover,
        width: width,
        height: height,
        'assets/icons/svg_icons/$icon',
        colorFilter:
          ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
