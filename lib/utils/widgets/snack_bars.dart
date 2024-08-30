import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class MobenSnackBars{
  nextUpdateSnackBar(){
    return Get.snackbar(
      'هذه الخدمة غير متوفرة ',
      "ستتوفر هذة الميزة في التحديث القادم للتطبيق",
      colorText: Colors.white,
      backgroundColor: AppColors.primaryColor,
      icon: const Icon(
        Icons.upcoming,
        color: AppColors.accentColor,
      ),
      borderColor: AppColors.accentColor,
      borderWidth: 2,
    );
  }
  finishZekrSnackBar(){
    return Get.snackbar(
      'تهانينا',
      'لقد أكملت جميع الأذكار في هذه الفئة!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        CupertinoIcons.checkmark_alt_circle_fill,
        color: AppColors.accentColor,
      ),
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      borderColor: AppColors.accentColor,
      borderWidth: 2,
    );
  }
}
