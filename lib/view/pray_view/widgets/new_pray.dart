import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/view/pray_view/widgets/pray_counter.dart';

import '../../../controller/pray_counter_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_text_field.dart';

class NewPray extends StatelessWidget {
  NewPray({
    super.key,
  });

  final PrayCounterController prayCounterController = PrayCounterController();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.5,
      width: screenWidth(context) * 0.9,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.whiteColor.withOpacity(0.3), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GetBuilder(
        init: prayCounterController,
        builder: (value){
          return Column(
            children: [
              Text(
                'بدء صلاة',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              const Divider(
                thickness: 0.5,
              ),
              PrayCounter(
                label: 'الركعات',
                increment: () {
                  value.rakaaIncrement();
                },
                decrement: () {
                  value.rakaaDecrement();
                },
                value: value.rakaa,
              ),
              PrayCounter(
                label: 'سجدات القراءة',
                increment: () {
                  value.sagdaIncrement();
                },
                decrement: () {
                  value.sagdaDecrement();
                },
                value: value.sagda,
              ),
              PrayCounter(
                label: 'جلسات التشهد',
                increment: () {
                  value.tashahodIncrement();
                },
                decrement: () {
                  value.tashahodDecrement();
                },
                value: value.tashahod,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    height:  screenHeight(context) * 0.06,
                    width: screenWidth(context) * 0.6,
                    onChanged: (val) {},
                    obscureText: true,
                    hint: 'مثال: صلاة الظهر',
                    color: AppColors.secAccentColor,
                    textInputType: TextInputType.number,
                    icon: Icons.clean_hands_rounded,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                              AppColors.secAccentColor.withOpacity(0.2),
                              offset: const Offset(0, -10),
                              spreadRadius: 10,
                              blurRadius: 15,
                            )
                          ]),
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(AppRouter.cameraViewPath,);
                        },
                        icon: const Icon(
                          Icons.play_arrow_outlined,
                          color: AppColors.secAccentColor,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
