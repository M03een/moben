import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/controller/surah_controller.dart';
import 'package:moben/core/utils/app_router.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/core/utils/widgets/glass_container.dart';
import 'package:moben/core/utils/widgets/gradient_text.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/colors.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final SurahController surahController = Get.put(SurahController());
  String userName = 'User Name';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'ضيف';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GradientText(
                text: userName,
                gradient: const LinearGradient(colors: [AppColors.accentColor,AppColors.secAccentColor]),
                style: AppStyles.textStyle19.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          DrawerButton(
            surahController: surahController,
            onTap: () {
              surahController.key.currentState!.closeEndDrawer();
              Get.toNamed(AppRouter.azkarViewPath);
            },
            icon: HugeIcons.strokeRoundedHandPrayer,
            label: 'الأذكار',
          ),
          DrawerButton(
            surahController: surahController,
            onTap: () {
              MobenSnackBars().nextUpdateSnackBar();
            },
            icon: HugeIcons.strokeRoundedQuran02,
            label: 'القرأن الكريم',
          ),
          DrawerButton(
            surahController: surahController,
            onTap: () {
              Get.toNamed(AppRouter.downloadViewPath);
            },
            icon: HugeIcons.strokeRoundedInboxDownload,
            label: 'التحميلات',
          ), DrawerButton(
            surahController: surahController,
            onTap: () {
              MobenSnackBars().nextUpdateSnackBar();
            },
            icon: HugeIcons.strokeRoundedUserAccount,
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
    required this.surahController,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final SurahController surahController;

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
