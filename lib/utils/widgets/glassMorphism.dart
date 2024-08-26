import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism(
      {Key? key,
        required this.child,
        required this.blur,
        required this.opacity,
        required this.color,
        this.borderRadius, required this.width, required this.height})
      : super(key: key);
  final Widget child;
  final double blur;
  final double opacity;
  final double width;
  final double height;
  final Color color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: color.withOpacity(opacity), borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
