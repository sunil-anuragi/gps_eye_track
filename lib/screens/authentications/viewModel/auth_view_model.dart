import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/util/base_controller.dart';
import '../../dashboard/view/dashboard_view.dart';

class AuthViewModel extends BaseController {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final userIdController = TextEditingController();
  final rememberMe = false.obs;
  final obscurePassword = true.obs;
  final selectedResetMethod = 'email'.obs;

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
    accountController.clear();
    passwordController.clear();
    Get.offAllNamed(DashboardView.dashboardView);
  }

  void continueForgotPassword() {}
}
