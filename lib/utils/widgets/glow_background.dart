import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';

import '../../utils/widgets/glow_container.dart';

class GlowBackground extends StatelessWidget {
  const GlowBackground(
      {super.key,
      required this.child,
      required this.color,
      required this.bottomPosition,
      required this.rightPosition,
      this.lPadding,
      this.tPadding,
      this.rPadding,
      this.bPadding});

  final Widget child;
  final Color color;
  final double bottomPosition;
  final double rightPosition;
  final double? lPadding;
  final double? tPadding;
  final double? rPadding;
  final double? bPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlowContainer(
            color: color,
            bottomPosition: bottomPosition,
            rightPosition: rightPosition,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
               lPadding ?? screenWidth(context) * 0.05,
                tPadding ?? screenHeight(context) * 0.04,
                rPadding ?? screenWidth(context) * 0.05,
                bPadding ?? 0,
              ),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
