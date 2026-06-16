import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:gps_software/screens/authentications/view/reset_password_view.dart';
// import 'package:gps_software/screens/authentications/widget/congratulations_dialog.dart';
import 'package:gps_software/util/base_controller.dart';

import '../../dashboard/view/dashboard_view.dart';

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
    Get.offAllNamed(DashboardView.dashboardView);
  }

  void continueForgotPassword() {
    // Validate userid before continuing if needed
    // Get.toNamed(ResetPasswordView.resetPasswordView);
  }
}
