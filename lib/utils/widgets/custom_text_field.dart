import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';
import 'glass_container.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, required this.onChanged, required this.hint,
  });
  final Function(String) onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 12,
      height: screenHeight(context) * 0.07,
      width: screenWidth(context) * 0.9,
      verticalPadding: 10,
      horizontalPadding: 10,
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.accentColor),
        decoration: InputDecoration(
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: AppColors.accentColor.withOpacity(0.6),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.accentColor.withOpacity(0.6),
              fontSize: 20,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
