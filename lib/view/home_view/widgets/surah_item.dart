import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/glass_container.dart';

class SurahItem extends StatelessWidget {
  final String surahName;
  final bool isMakkia;

  const SurahItem({
    super.key, required this.surahName, required this.isMakkia,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: GlassContainer(
          height: screenHeight(context) * 0.11,
          width: screenWidth(context) * 0.9,
          horizontalPadding: screenWidth(context) * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(surahName,style: AppStyles.quranTextStyle30,),
              Image.asset(
              isMakkia ?'assets/icons/makkia.png'
                :'assets/icons/not_makkia.png',
                scale: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
