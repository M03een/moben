import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';

import '../../../controller/reader_controller.dart';

class CustomBottomSheet extends StatelessWidget {
  final ReaderController controller = Get.put(ReaderController());
  final Widget child;

  CustomBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.6,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth(context) * 0.18,
            height: screenHeight(context) * 0.008,
            decoration: BoxDecoration(
                color: AppColors.accentColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20)),
          ),
          (screenHeight(context) * 0.08).sh,
          child,
        ],
      ),
    );
  }
}