import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/view/bottom_bar_view.dart';
import 'package:gps_software/screens/authentications/view/reset_password_view.dart';
import 'package:gps_software/screens/authentications/widget/congratulations_dialog.dart';
import 'package:gps_software/util/base_controller.dart';

class AuthViewModel extends BaseController {
  // Sign In text controllers
  final accountController = TextEditingController();
  final passwordController = TextEditingController();

  // Forget Password text controller
  final userIdController = TextEditingController();

  // Observable states
  final rememberMe = false.obs;
  final obscurePassword = true.obs;
  final selectedResetMethod = 'email'.obs; // 'email' or 'phone'

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? val) {
    if (val != null) {
      rememberMe.value = val;
    }
  }

  void selectResetMethod(String method) {
    selectedResetMethod.value = method;
  }

  void login() {
    // Clear fields
    accountController.clear();
    passwordController.clear();
    Get.offAllNamed(BottomBarView.bottomBarView);
  }

  void continueForgotPassword() {
    // Validate userid before continuing if needed
    Get.toNamed(ResetPasswordView.resetPasswordView);
  }

  void resetPassword(BuildContext context) {
    // Show congratulations success popup
    showCongratulationsDialog(context);
  }

  void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return const CongratulationsDialog();
      },
    );
  }
}
