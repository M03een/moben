import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/env/env.dart';
import 'core/service/permission_handler.dart';
import 'core/shared_prefrences/auth_shared_pref.dart';
// test
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthSharedPref authSharedPref = AuthSharedPref();
  bool isLoggedIn = await authSharedPref.isLoggedIn();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  print('=======================');
  print('${Supabase.instance.client.auth.getUser()}');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.moben',
    androidNotificationChannelName: 'moben',
    androidNotificationOngoing: true,
  );

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({super.key, required this.isLoggedIn});

  final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  final MobenPermissionHandler _mobenPermissionHandler =
      MobenPermissionHandler();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    _mobenPermissionHandler.checkLocationPermission();
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moben',
        theme: ThemeData(
            appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.primaryColor,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
            useMaterial3: true,
            fontFamily: 'Rubik',
            scrollbarTheme: const ScrollbarThemeData(
              thumbColor: WidgetStatePropertyAll(AppColors.secAccentColor),
              mainAxisMargin: 200,
              minThumbLength: 70,
              radius: Radius.circular(15),
            )),
        translations: AppStrings(),
        locale: const Locale('ar'),
        initialRoute: isLoggedIn
            ? AppRouter.bottomNavigationPath
            : AppRouter.loginViewPath,
        getPages: AppRouter.routes,
      ),
    );
  }
}
