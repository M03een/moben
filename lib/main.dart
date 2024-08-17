import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/utils/app_router.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/local.dart';

Future<void> main() async{
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.moben',
    androidNotificationChannelName: 'moben',
    androidNotificationOngoing: true,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moben',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
          useMaterial3: true,
          fontFamily: 'Rubik',
          scrollbarTheme: const ScrollbarThemeData(
            thumbColor: WidgetStatePropertyAll(AppColors.accentColor),
            mainAxisMargin: 200,
            minThumbLength: 70,
            radius: Radius.circular(15),
          )

        ),
        translations: AppStrings(),
        locale: const Locale('ar'),
        getPages: AppRouter.routes,
      ),
    );
  }
}
