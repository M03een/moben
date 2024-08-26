import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/utils/size_config.dart';

import '../../utils/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 0.0;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(AppRouter.bottomViewPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: Image.asset(
            'assets/images/logo.png',
            width: screenWidth(context) * 0.3,
            height: screenHeight(context) * 0.4,
          ),
        ),
      ),
    );
  }
}
