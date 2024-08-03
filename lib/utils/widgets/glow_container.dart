import 'package:flutter/material.dart';

class GlowContainer extends StatelessWidget {
  final double bottomPosition;
  final double rightPosition;
  final Color color;

  const GlowContainer({
    super.key,
    required this.bottomPosition,
    required this.rightPosition, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomPosition,
      right: rightPosition,
      child: Container(
        width: 700,
        height: 700,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            radius: 1.2,
            center: Alignment.center,
            colors: [
             color,
              Colors.transparent,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
