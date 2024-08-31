import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/styles.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _begin = 0.0;

  final Stream<QiblahDirection> flutterQiblah = FlutterQiblah.qiblahStream;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 0.0).animate(_animationController);

  }



  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: flutterQiblah,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: AppColors.accentColor,
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          final qiblahDirection = snapshot.data!;
          _animation = Tween(
            begin: _begin,
            end: (qiblahDirection.qiblah * (pi / 180) * -1),
          ).animate(_animationController);
          _begin = (qiblahDirection.qiblah * (pi / 180) * -1);
          _animationController.forward(from: 0);

          return Center(
            child: SizedBox(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SvgPicture.asset('assets/images/qiblah.svg'),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تأكد من تشغيل ال Location',
                    style: AppStyles.textStyle24.copyWith(color: AppColors.accentColor)),
                Text('تأكد من السماح بأذونات الموقع من الإعدادات',
                    style: AppStyles.textStyle24.copyWith(color: AppColors.accentColor)),
                Text('و لو ايفون مش ذنبي',
                    style: AppStyles.textStyle24.copyWith(color: AppColors.accentColor)),
              ],
            ),
          );
        }
      },
    );
  }
}
