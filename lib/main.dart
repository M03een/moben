import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moben/service/permission_handler.dart';
import 'package:moben/utils/app_router.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();
  final String? supabaseUrl = dotenv.env['supabaseUrl'];
  final String? supabaseAnonKey = dotenv.env['supabaseAnonKey'];
  await Supabase.initialize(
    url: 'https://milycytlxounhxrzosym.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1pbHljeXRseG91bmh4cnpvc3ltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjUwMzAxMjgsImV4cCI6MjA0MDYwNjEyOH0._Y9d_8tkthQXSZf9KwNZH6OYdsv31RgZPqzKI2zbuCQ',
  );
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.moben',
    androidNotificationChannelName: 'moben',
    androidNotificationOngoing: true,
  );
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});
  final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
    final MobenPermissionHandler _mobenPermissionHandler = MobenPermissionHandler();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    _mobenPermissionHandler.checkLocationPermission();
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moben',
        theme: ThemeData(
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
        getPages: AppRouter.routes,
      ),
    );
  }
}
