import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/change_password/widget/password_underline_field.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class ChangePasswordView extends GetView<AccountViewModel> {
  static const changePasswordView = '/changePasswordView';

  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const AccountModuleAppBar(title: AppStrings.changePassword),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              return PasswordUnderlineField(
                label: AppStrings.currentPassword,
                controller: controller.currentPasswordController,
                isVisible: controller.isCurrentPasswordVisible.value,
                onToggleVisibility: controller.toggleCurrentPasswordVisibility,
              );
            }),
            28.h.sizeBoxFromHeight(),
            Obx(() {
              return PasswordUnderlineField(
                label: AppStrings.newPassword,
                controller: controller.newPasswordController,
                isVisible: controller.isNewPasswordVisible.value,
                onToggleVisibility: controller.toggleNewPasswordVisibility,
              );
            }),
            28.h.sizeBoxFromHeight(),
            Obx(() {
              return PasswordUnderlineField(
                label: AppStrings.confirmPassword,
                controller: controller.confirmPasswordController,
                isVisible: controller.isConfirmPasswordVisible.value,
                onToggleVisibility: controller.toggleConfirmPasswordVisibility,
              );
            }),
            48.h.sizeBoxFromHeight(),
            CustomWidget.customButton(
              callBack: controller.onChangePassword,
              btnText: AppStrings.changePasswordUpper,
              borderRadius: 6.0,
              color: AppColors.primaryColor,
              width: double.infinity,
              height: 48,
              fontWeight: FontWeight.w600,
              textSize: 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
