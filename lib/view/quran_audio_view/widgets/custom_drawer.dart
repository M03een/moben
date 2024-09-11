import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/controller/user_auth_controller.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final SurahController surahController = Get.put(SurahController());
  final UserAuthController authController = Get.put(UserAuthController());
  String userName = 'User Name';
  String email = 'empty email';

  @override
  void initState() {
    super.initState();
    _loadUserNameAndEmail();
  }

  Future<void> _loadUserNameAndEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'ضيف';
      email = prefs.getString('email') ?? 'مفيش';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (screenHeight(context) * 0.06).sh,
              Container(
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
              (screenHeight(context) * 0.01).sh,
              GradientText(
                text: userName,
                gradient: const LinearGradient(
                    colors: [AppColors.accentColor, AppColors.secAccentColor]),
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                email,
                style: AppStyles.textStyle19.copyWith(
                  color: AppColors.whiteColor.withOpacity(
                    0.3,
                  ),
                ),
              ),
              (screenHeight(context) * 0.01).sh,
            ],
          ),
          DrawerButton(
            onTap: () {
              surahController.key.currentState!.closeEndDrawer();
              Get.toNamed(AppRouter.azkarViewPath);
            },
            icon: HugeIcons.strokeRoundedHandPrayer,
            label: 'الأذكار',
          ),
          DrawerButton(
            onTap: () {
              MobenSnackBars().nextUpdateSnackBar();
            },
            icon: HugeIcons.strokeRoundedQuran02,
            label: 'القرأن الكريم',
          ),
          DrawerButton(
            onTap: () {
              Get.toNamed(AppRouter.downloadViewPath);
            },
            icon: HugeIcons.strokeRoundedInboxDownload,
            label: 'التحميلات',
          ),
          DrawerButton(
            onTap: () {
              MobenSnackBars().nextUpdateSnackBar();
            },
            icon: HugeIcons.strokeRoundedUserAccount,
            label: 'حسابي',
          ),
          DrawerButton(
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
                              .copyWith(color: AppColors.secAccentColor),
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
            icon: HugeIcons.strokeRoundedDoor01,
            label: 'تسجيل الخروج',
          ),
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth(context) * 0.02),
      child: GlassContainer(
        height: screenHeight(context) * 0.06,
        width: screenWidth(context) * 0.8,
        horizontalPadding: screenWidth(context) * 0.02,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppStyles.textStyle19
                  .copyWith(color: AppColors.secAccentColor),
            ),
            HugeIcon(
              icon: icon,
              color: AppColors.secAccentColor,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
