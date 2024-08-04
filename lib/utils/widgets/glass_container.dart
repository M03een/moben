import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.borderRadius,
    this.virMargin,
    this.horMargin,
  });

  final double height;
  final double width;
  final Widget child;
  final double? horizontalPadding;

  final double? verticalPadding;

  final double? borderRadius;

  final double? virMargin;

  final double? horMargin;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: virMargin ?? 0, horizontal: horMargin ?? 0),
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 0,
              horizontal: horizontalPadding ?? 0),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 15))),
          child: child,
        ),
      ),
    );
  }
}
