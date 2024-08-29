import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/glass_container.dart';
import 'package:moben/view/qiblah_view/widgets/qiblah_compass.dart';
import 'package:moben/view/qiblah_view/widgets/qiblah_mesh.dart';

import '../../../utils/widgets/glassMorphism.dart';

class QiblahViewBody extends StatelessWidget {
  const QiblahViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
                child:  Column(
                  children: [
                    const Text(
                      'القبلة',
                      style: AppStyles.quranTextStyle50,
                    ),
                    (screenHeight(context)*0.1).sh,
                    QiblahCompass()
                  ],
                ),
              ),
            ),
          ],
        ), // Reusable mesh animation component
      );
  }
}
