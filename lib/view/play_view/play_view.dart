import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/glass_container.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../../utils/widgets/glow_container.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlowContainer(
            color: AppColors.accentColor.withOpacity(0.35),
            bottomPosition: screenHeight(context) * 0.6,
            rightPosition: screenWidth(context) * -0.5,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth(context) * 0.05,
                screenHeight(context) * 0.04,
                screenWidth(context) * 0.05,
                0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الفاتحة',
                        style: AppStyles.quranTextStyle30,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          CupertinoIcons.chevron_down,
                          size: 30,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                  (screenHeight(context) * 0.02).sh,
                  Row(
                    children: [
                      GlassContainer(
                        horMargin: 5,
                        height: screenHeight(context) * 0.15,
                        width: screenWidth(context) * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.person_fill,
                                    color: AppColors.accentColor,
                                    size: 25,
                                  ),
                                  Text(
                                    'القارئ',
                                    style: AppStyles.textStyle19
                                        .copyWith(color: AppColors.accentColor),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    'ابوبكر الشاطري',
                                    style: AppStyles.textStyle15.copyWith(
                                        color: AppColors.accentColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.chevron_compact_down,
                                      color: AppColors.accentColor,
                                      size: 25,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GlassContainer(
                          height: screenHeight(context) * 0.15,
                          width: 200,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  height: (screenHeight(context) * 0.1),
                                  decoration: BoxDecoration(
                                      color: AppColors.accentColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Text(
                                        'جاري التحميل...${70}',
                                        style: AppStyles.textStyle15.copyWith(
                                            color: AppColors.primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  (screenHeight(context) * 0.01).sh,
                  GlassContainer(
                    horMargin: 5,
                    height: screenHeight(context) * 0.15,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.book_fill,
                                color: AppColors.accentColor,
                                size: 25,
                              ),
                              Text(
                                'السورة',
                                style: AppStyles.textStyle19
                                    .copyWith(color: AppColors.accentColor),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                'الفاتحة',
                                style: AppStyles.textStyle15.copyWith(
                                    color: AppColors.accentColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.chevron_compact_down,
                                  color: AppColors.accentColor,
                                  size: 25,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'مكية',
                                style: AppStyles.textStyle15.copyWith(
                                    color: AppColors.accentColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  (screenHeight(context) * 0.01).sh,
                  const Row(
                    children: [

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
