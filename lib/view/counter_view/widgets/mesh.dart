import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';

final meshRect = OMeshRect(
  width: 3,
  height: 4,
  colorSpace: OMeshColorSpace.xyY,
  fallbackColor: const Color(0xff0e0e0e),
  backgroundColor: const Color(0xff0e0e0e),
  vertices: [
    (-0.12, -0.21).v.bezier(east: (-0.05, -0.04).v, south: (-0.21, -0.03).v, ),    (0.38, -0.25).v.bezier(east: (0.76, -0.23).v, west: (0.18, -0.27).v, ),    (0.99, -0.34).v.bezier(west: (0.93, -0.24).v, ),  // Row 1
    (-0.12, 0.55).v,    (0.48, 0.48).v.bezier(east: (0.99, 0.5).v, ),    (1.05, 0.28).v,  // Row 2
    (-0.12, 0.67).v,    (0.5, 0.71).v.bezier(east: (0.86, 0.69).v, south: (0.53, 0.74).v, ),    (1.04, 0.71).v.bezier(west: (0.86, 0.67).v, ),  // Row 3
    (-0.12, 1.16).v.bezier(east: (0.07, 1.07).v, ),    (0.44, 1.22).v.bezier(east: (0.61, 1.22).v, west: (0.19, 1.32).v, ),    (1.09, 1.1).v,  // Row 4
  ],
  colors: const [
    null,    null,    null,  // Row 1
    Color(0xff5af49a),    Color(0xff46e1b7),    Color(0xff31cce4),  // Row 2
    Color(0xff5af49a),    Color(0xff46e1b7),    Color(0xff31cce4),  // Row 3
    null,    null,    null,  // Row 4
  ],
);