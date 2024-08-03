import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/app_router.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moben',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
        useMaterial3: true,
        fontFamily: 'Rubik',

      ),
      translations: AppStrings(),
      locale: const Locale('ar'),
      getPages: AppRouter.routes,
    );
  }
}
