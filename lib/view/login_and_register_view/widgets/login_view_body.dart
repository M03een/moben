import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/utils/colors.dart';
import 'package:moben/utils/size_config.dart';
import 'package:moben/utils/styles.dart';
import 'package:moben/utils/widgets/custom_text_field.dart';

import '../../../utils/widgets/gradient_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.secAccentColor.withOpacity(0.2),
            AppColors.accentColor.withOpacity(0.2),
          ],
        ),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        // key: ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (screenHeight(context) * 0.07).sh,
            Image.asset(
              'assets/images/logo.png',
              width: screenWidth(context) * 0.3,
              height: screenHeight(context) * 0.1,
            ),
            (screenHeight(context) * 0.15).sh,
            Text(
              'تسجيل الدخول',
              style: AppStyles.textStyle35.copyWith(
                color: AppColors.whiteColor.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              ),
            ),
            (screenHeight(context) * 0.03).sh,
            CustomTextField(
              onChanged: (val) {},
              hint: 'الأيميل',
              color: AppColors.whiteColor,
              icon: CupertinoIcons.at,
              validator: (value){
               // here
              },
            ),
            (screenHeight(context) * 0.02).sh,
            CustomTextField(
              onChanged: (val) {},
              hint: 'الباسورد',
              color: AppColors.whiteColor,
              icon: CupertinoIcons.lock,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedViewOff,
                  color: AppColors.whiteColor.withOpacity(
                    0.3,
                  ),
                  size: 40,
                ),
              ),
              validator: (value){
                //here
              },
            ),
            (screenHeight(context) * 0.01).sh,
            TextButton(
              onPressed: () {},
              child: Text(
                'ليس لديك حساب ؟',
                style: AppStyles.textStyle19.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.whiteColor.withOpacity(0.3),
                ),
              ),
            ),
            (screenHeight(context) * 0.03).sh,
            GradientButton(
              width: screenWidth(context) * 0.9,
              onTap: () {},
              child: Text(
                'تسجيل الدخول',
                style: AppStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            (screenHeight(context) * 0.02).sh,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientButton(
                  width: screenWidth(context) * 0.15,
                  onTap: () {},
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedNewTwitter,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
                GradientButton(
                  width: screenWidth(context) * 0.15,
                  onTap: () {},
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedGoogle,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
              ],
            ),
            (screenHeight(context) * 0.07).sh,
            TextButton(
              onPressed: () {},
              child: Text(
                'كلمنا',
                style: AppStyles.textStyle19.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.whiteColor.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
