

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/bottom_nav_controller.dart';

import '../../../controller/user_auth_controller.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/widgets/custom_icon.dart';
import '../../../core/utils/widgets/glass_container.dart';
import '../../../core/utils/widgets/snack_bars.dart';

class VerticalNavBar extends StatelessWidget {
    VerticalNavBar({super.key});

  final BottomNavController bottomNavController = Get.put(BottomNavController());
    final UserAuthController authController = Get.put(UserAuthController());

    @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: GlassContainer(
        height: screenHeight(context)*0.88,
        width: screenWidth(context) * 0.05,
        color: bottomNavController.currentSelectedIndex.value == 1 ? AppColors.primaryColor : null,
        child: Obx(() =>
            Column(
              children: [
                InkWell(
                  onTap: (){
                    Get.toNamed(AppRouter.accountAndRankViewPath);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: screenWidth(context) * 0.2,
                    height: screenHeight(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColors.secAccentColor, AppColors.accentColor],
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile_avatar.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  width: screenWidth(context) * 0.7,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16)),
                ),
                (screenHeight(context)*0.1).sh,
                CustomIcon(
                  icon: 'waveform.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(0);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 0,
                  color: bottomNavController.currentSelectedIndex.value == 0
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'bell-concierge.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(1);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 1,
                  color: bottomNavController.currentSelectedIndex.value == 1
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'navigation.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(2);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 2,
                  color: bottomNavController.currentSelectedIndex.value == 2
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'kaaba.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(3);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 3,
                  color: bottomNavController.currentSelectedIndex.value == 3
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                //
                CustomIcon(
                  icon: 'azkar.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(4);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 4,
                  color: bottomNavController.currentSelectedIndex.value == 4
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'downloads.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(5);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 5,
                  color: bottomNavController.currentSelectedIndex.value == 5
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'bell.svg',
                  onTap: () {
                    bottomNavController.updateCurrentIndex(6);
                  },
                  isSelected: bottomNavController.currentSelectedIndex.value == 6,
                  color: bottomNavController.currentSelectedIndex.value == 6
                      ? AppColors.secAccentColor
                      : AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'quran.svg',
                  onTap: () {
                    MobenSnackBars().nextUpdateSnackBar();
                  },
                  isSelected: false,
                  color: AppColors.whiteColor.withOpacity(0.2),
                ),
                CustomIcon(
                  icon: 'logout.svg',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.primaryColor,
                          title: Text(
                            'تسجيل الخروج',
                            style: AppStyles.textStyle19
                                .copyWith(color: AppColors.accentColor),
                          ),
                          content: Text(
                            'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                            style: AppStyles.textStyle15
                                .copyWith(color: AppColors.accentColor),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child:   Text(
                                'إلغاء',
                                style: AppStyles.textStyle15
                                    .copyWith(color: AppColors.accentColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                authController.accountLogout(context);
                                Navigator.of(context)
                                    .pop();
                                Get.offNamed(AppRouter.loginViewPath);
                              },
                              child:   Text(
                                'تسجيل الخروج',
                                style: AppStyles.textStyle15
                                    .copyWith(color: AppColors.errorColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  isSelected: false,
                  color: AppColors.whiteColor.withOpacity(0.2),
                ),
              ],
            )),
      ),
    )
    ;
  }
}



