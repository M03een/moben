import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';
import 'glass_container.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, required this.onChanged, required this.hint, this.icon, this.textInputType, this.color,
  });
  final Function(String) onChanged;
  final String hint;
  final IconData? icon;
  final TextInputType? textInputType;
  final Color? color;



  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 12,
      height: screenHeight(context) * 0.07,
      width: screenWidth(context) * 0.9,
      verticalPadding: 10,
      horizontalPadding: 10,
      child: TextField(
        keyboardType: textInputType ?? TextInputType.none,
        onChanged: onChanged,
        style:  TextStyle(color:color ??  AppColors.accentColor),
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon ?? CupertinoIcons.search,
              color: color?.withOpacity(0.6) ?? AppColors.accentColor.withOpacity(0.6),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color:color?.withOpacity(0.6) ??  AppColors.accentColor.withOpacity(0.6),
              fontSize: 20,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,

        ),
      ),
    );
  }
}
