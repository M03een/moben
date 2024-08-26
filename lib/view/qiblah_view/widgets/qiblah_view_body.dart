import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/glass_container.dart';
import 'package:moben/view/qiblah_view/widgets/qiblah_mesh.dart';

import '../../../utils/widgets/glassMorphism.dart';

class QiblahViewBody extends StatelessWidget {
  const QiblahViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const MeshAnimation(),
            Align(
              alignment: Alignment.center,
              child: GlassMorphism(
                blur: 10,
                opacity: 0.2,
                color: Colors.black,
                height: screenHeight(context) * 0.7,
                width: screenWidth(context) * 0.8,
                borderRadius: BorderRadius.circular(15),
                child: const Column(
                  children: [
                    Text(
                      'القبلة',
                      style: AppStyles.quranTextStyle50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), // Reusable mesh animation component
      ),
    );
  }
}
