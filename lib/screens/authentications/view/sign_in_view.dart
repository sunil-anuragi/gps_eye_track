import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/authentications/view/forget_password_view.dart';
import 'package:gps_software/screens/authentications/viewModel/auth_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class SignInView extends GetView<AuthViewModel> {
  static const signInView = '/signInView';

  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      assignId: true,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.h.sizeBoxFromHeight(),

                  Center(
                    child: Image.asset(
                      Assets.assetsGpsLogo,
                      height: 180.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  40.h.sizeBoxFromHeight(),

                  CustomWidget.text(
                    AuthStrings.signIn,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                  24.h.sizeBoxFromHeight(),

                  CustomWidget.customTextFormField(
                    hintText: AuthStrings.account,
                    labelText: AuthStrings.account,
                    controller: controller.accountController,
                    isPrefixShow: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(
                        Icons.person_outline,
                        size: 22.w,
                        color: AppColors.black87,
                      ),
                    ),
                  ),
                  16.h.sizeBoxFromHeight(),
                  // Password Field
                  Obx(
                    () => CustomWidget.customTextFormField(
                      hintText: AuthStrings.passwordHint,
                      labelText: AuthStrings.password,
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      isPrefixShow: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Icon(
                          Icons.lock_outline,
                          size: 22.w,
                          color: AppColors.black87,
                        ),
                      ),
                      isSufixShow: true,
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleObscurePassword,
                        child: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 22.w,
                          color: AppColors.black54,
                        ),
                      ),
                    ),
                  ),
                  16.h.sizeBoxFromHeight(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: controller.toggleRememberMe,
                                activeColor: AppColors.primaryColor,
                                checkColor: Colors.white,
                              ),
                            ),
                          ),
                          8.w.sizeBoxFromWidth(),
                          GestureDetector(
                            onTap: () => controller
                                .toggleRememberMe(!controller.rememberMe.value),
                            child: CustomWidget.text(
                              AuthStrings.rememberMe,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black87,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () =>
                            Get.toNamed(ForgetPasswordView.forgetPasswordView),
                        child: CustomWidget.text(
                          AuthStrings.forgetPasswordLink,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueColor,
                        ),
                      ),
                    ],
                  ),
                  40.h.sizeBoxFromHeight(),
                  // Login button
                  Center(
                    child: CustomWidget.customButton(
                      callBack: controller.login,
                      btnText: AuthStrings.login,
                      borderRadius: 24.0,
                      color: AppColors.primaryColor,
                      width: double.infinity,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
