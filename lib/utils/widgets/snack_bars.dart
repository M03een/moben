import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

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