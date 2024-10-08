import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/utils/app_router.dart';

class UserAuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var nameTextController = TextEditingController().obs;
  var loginEmailTextController = TextEditingController().obs;
  var loginPasswordTextController = TextEditingController().obs;
  var registerEmailTextController = TextEditingController().obs;
  var registerPasswordTextController = TextEditingController().obs;
  var isLoginPasswordVisible = true.obs;
  var isRegisterPasswordVisible = true.obs;

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisible.value = !isLoginPasswordVisible.value;
  }

  void toggleRegisterPasswordVisibility() {
    isRegisterPasswordVisible.value = !isRegisterPasswordVisible.value;
  }

  Future<void> _saveUserNameAndEmail({required String name,required String email}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('email', email);
  }

  Future<void> accountLogin(BuildContext context) async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: loginEmailTextController.value.text.trim(),
        password: loginPasswordTextController.value.text.trim(),
      );

      if (response.session == null) {
        isLoading.value = false;
        MobenSnackBars()
            .erroeSnackBar(title: 'خطأ', subtitle: 'إيميل او باسورد غلط');
        return;
      }

      final user = response.user;
      final userName = user?.userMetadata?['name'] ?? 'No Name Found';

      await _saveUserNameAndEmail(name: userName,email: user?.email ?? 'no email signed');

      if (!context.mounted) return;
      isLoading.value = false;
      Get.offNamed(AppRouter.bottomNavigationPath);
    } on AuthException catch (e) {
      isLoading.value = false;
      MobenSnackBars().erroeSnackBar(title: 'خطأ', subtitle: e.message);
    } catch (e) {
      isLoading.value = false;
      MobenSnackBars()
          .erroeSnackBar(title: 'خطأ', subtitle: 'حدث خطأ غير متوقع');
    }
  }

  Future<void> accountRegister(BuildContext context) async {
    isLoading.value = true;
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: registerEmailTextController.value.text.trim(),
        password: registerPasswordTextController.value.text.trim(),
        data: {
          'name': nameTextController.value.text.trim(),
        },
      );

      if (response.user == null) {
        isLoading.value = false;
        MobenSnackBars().erroeSnackBar(
            title: 'خطأ', subtitle: 'حدث خطأ اثناء التسجيل . جرب مرة تانية');
        return;
      }

      final user = response.user;
      final userName = user?.userMetadata?['name'] ?? 'No Name Found';
      await _saveUserNameAndEmail(name: userName,email: user?.email ?? 'no email signed');

      MobenSnackBars().registerSnackBar();

      if (!context.mounted) return;
      isLoading.value = false;
      Get.toNamed(AppRouter.loginViewPath);
    } on AuthException catch (e) {
      isLoading.value = false;
      MobenSnackBars().erroeSnackBar(title: 'خطأ', subtitle: e.message);
    } catch (e) {
      isLoading.value = false;
      MobenSnackBars()
          .erroeSnackBar(title: 'خطأ', subtitle: 'حدث خطأ غير متوقع');
    }
  }

  Future<void> accountLogout(BuildContext context) async {
    isLoading.value = true;
    try {
      await Supabase.instance.client.auth.signOut();

      if (!context.mounted) return;

      Get.toNamed(AppRouter.loginViewPath);
    } catch (e) {
      isLoading.value = false;
      MobenSnackBars()
          .erroeSnackBar(title: 'خطأ', subtitle: 'حدث خطأ اثناء تسجيل الخروج');
    }
  }
}
