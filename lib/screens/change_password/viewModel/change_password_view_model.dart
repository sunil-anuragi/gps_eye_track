import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:gps_software/util/user_details.dart';

class ChangePasswordViewModel extends BaseController {
  final oldController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  final obscureOld = true.obs;
  final obscureNew = true.obs;
  final obscureConfirm = true.obs;
  final isLoading = false.obs;

  static const int minLength = 6;

  Future<void> submit() async {
    Get.focusScope?.unfocus();
    final oldPassword = oldController.text.trim();
    final newPassword = newController.text.trim();
    final confirm = confirmController.text.trim();

    String? error;
    if (oldPassword.isEmpty) {
      error = 'Please enter your old password';
    } else if (newPassword.length < minLength) {
      error = 'New password must be at least $minLength characters';
    } else if (newPassword == oldPassword) {
      error = 'New password must be different from the old one';
    } else if (confirm != newPassword) {
      error = 'Passwords do not match';
    }
    if (error != null) {
      showSnack(msg: error);
      return;
    }

    isLoading.value = true;
    // Checks against the saved login password when one is stored.
    // Send the change password API request from here.
    final saved = await UserDetails().getReloginCredentials;
    isLoading.value = false;
    if (saved != null && saved['password'] != oldPassword) {
      showSnack(msg: 'Old password is incorrect');
      return;
    }

    oldController.clear();
    newController.clear();
    confirmController.clear();
    Get.back();
    showSnack(msg: 'Password changed successfully');
  }

  @override
  void onClose() {
    oldController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
