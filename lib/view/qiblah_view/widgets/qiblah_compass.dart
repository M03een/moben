import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';

class QiblahCompass extends StatefulWidget {
    QiblahCompass({super.key});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;
  double _begin = 0.0;

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

  final Stream<QiblahDirection> flutterQiblah =FlutterQiblah.qiblahStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: flutterQiblah,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Color(0xff87854f),
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
          return const Center(
            child: Text('Unable to get Qiblah direction'),
          );
        }
      },
    );
  }
}
