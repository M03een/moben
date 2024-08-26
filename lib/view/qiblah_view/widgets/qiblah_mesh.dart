import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';


extension on OVertex {
  OVertex to(OVertex b, double t) => lerpTo(b, t);
}

extension on Color? {
  Color? to(Color? b, double t) => Color.lerp(this, b, t);
}

typedef C = Colors;
class MeshAnimation extends StatefulWidget {
  const MeshAnimation({super.key});

  @override
  _MeshAnimationState createState() => _MeshAnimationState();
}

class _MeshAnimationState extends State<MeshAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this)
    ..duration = const Duration(seconds: 5)
    ..forward()
    ..addListener(() {
      if (controller.value == 1.0) {
        controller.animateTo(0, curve: Curves.easeInOutQuint);
      }
      if (controller.value == 0.0) {
        controller.animateTo(1, curve: Curves.easeInOutCubic);
      }
    });

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final dt = controller.value;
        return OMeshGradient(
          tessellation: 12,
          size: Size.infinite,
          mesh: OMeshRect(
            width: 3,
            height: 4,
            colorSpace: OMeshColorSpace.lab,
            fallbackColor: Colors.transparent,
            vertices: [
              (0.0, 0.3).v.to((0.0, 0.0).v, dt),
              (0.5, 0.15).v.to((0.5, 0.1).v, dt * dt),
              (1.0, -0.1).v.to((1.0, 0.3).v, dt * dt), //

              (-0.05, 0.68).v.to((0.0, 0.45).v, dt),
              (0.63, 0.3).v.to((0.48, 0.54).v, dt),
              (1.0, 0.1).v.to((1.0, 0.6).v, dt), //

              (-0.2, 0.92).v.to((0.0, 0.58).v, dt),
              (0.32, 0.72).v.to((0.58, 0.69).v, dt * dt),
              (1.0, 0.3).v.to((1.0, 0.8).v, dt), //

              (0.0, 1.2).v.to((0.0, 0.86).v, dt),
              (0.5, 0.88).v.to((0.5, 0.95).v, dt),
              (1.0, 0.82).v.to((1.0, 1.0).v, dt), //
            ],
            colors: [
              null, null, null, //

              Color(0xFF31CCE4).withOpacity(0.8).to(Color(0xFF92F0AB), dt),
              Color(0xFF31CCE4).withOpacity(0.8).to(Color(0xFF92F0AB), dt),
              Color(0xFF31CCE4).withOpacity(0.9).to(Color(0xFF92F0AB), dt), //

              Color(0xFF31CCE4).to(Color(0xFF92F0AB), dt),
              Color(0xFF31CCE4).withOpacity(0.98).to(Color(0xFF92F0AB), dt),
              Color(0xFF31CCE4).to(Color(0xFF92F0AB), dt), //

              null, null, null, //
            ],
          ),
        );
      },
    );
  }
}
