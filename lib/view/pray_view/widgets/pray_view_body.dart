import 'package:flutter/material.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/view/pray_view/widgets/new_pray.dart';

class PrayViewBody extends StatelessWidget {
  const PrayViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            (screenHeight(context) * 0.07).sh,
            const Text('مراقب الصلاة',style: AppStyles.quranTextStyle50,),
            (screenHeight(context) * 0.03).sh,
        
            NewPray(),
          ],
        ),
      ),
    );
  }
}
