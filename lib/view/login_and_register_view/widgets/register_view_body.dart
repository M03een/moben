import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../controller/user_auth_controller.dart';
import '../../../utils/app_router.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/custom_text_field.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/snack_bars.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAuthController authController = Get.put(UserAuthController());

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
        key: authController.registerFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (screenHeight(context) * 0.07).sh,
              Image.asset(
                'assets/images/logo.png',
                width: screenWidth(context) * 0.3,
                height: screenHeight(context) * 0.1,
              ),
              (screenHeight(context) * 0.06).sh,
              Text(
                'إنشاء حساب',
                style: AppStyles.textStyle35.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              (screenHeight(context) * 0.06).sh,
              CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: authController.nameTextController.value,
                onChanged: (val) {},
                obscureText: false,
                hint: 'الاسم',
                color: AppColors.whiteColor,
                icon: CupertinoIcons.person_alt_circle_fill,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال اسمك';
                  }
                  return null;
                },
              ),
              (screenHeight(context) * 0.02).sh,
              CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: authController.registerEmailTextController.value,
                onChanged: (val) {},
                obscureText: false,
                hint: 'الأيميل',
                color: AppColors.whiteColor,
                icon: CupertinoIcons.at,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'البريد الإلكتروني غير صالح';
                  }
                  return null;
                },
              ),
              (screenHeight(context) * 0.02).sh,
              Obx(() => CustomTextField(
                    textInputType: TextInputType.visiblePassword,
                    controller:
                        authController.registerPasswordTextController.value,
                    onChanged: (val) {},
                    obscureText: authController.isRegisterPasswordVisible.value,
                    hint: 'الباسورد',
                    color: AppColors.whiteColor,
                    icon: CupertinoIcons.lock,
                    suffixIcon: IconButton(
                      onPressed:
                          authController.toggleRegisterPasswordVisibility,
                      icon: Icon(
                        authController.isRegisterPasswordVisible.value
                            ? HugeIcons.strokeRoundedViewOff
                            : HugeIcons.strokeRoundedView,
                        color: AppColors.whiteColor.withOpacity(0.3),
                        size: 30,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      } else if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
                      }
                      return null;
                    },
                  )),
              (screenHeight(context) * 0.01).sh,
              TextButton(
                onPressed: () {
                  Get.offNamed(AppRouter.loginViewPath);
                },
                child: Text(
                  'لديك حساب بالفعل ؟',
                  style: AppStyles.textStyle19.copyWith(
                    color: AppColors.whiteColor.withOpacity(0.3),
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.whiteColor.withOpacity(0.3),
                  ),
                ),
              ),
              (screenHeight(context) * 0.01).sh,
              GradientButton(
                width: screenWidth(context) * 0.9,
                onTap: () {
                  if (authController.registerFormKey.currentState!.validate()) {
                    authController.accountRegister(context);
                  }
                },
                child: Text(
                  'إنشئ حساب',
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
                    onTap: () {
                      MobenSnackBars().nextUpdateSnackBar();

                    },
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedNewTwitter,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                  ),
                  GradientButton(
                    width: screenWidth(context) * 0.15,
                    onTap: () {
                      MobenSnackBars().nextUpdateSnackBar();

                    },
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
      ),
    );
  }
}
