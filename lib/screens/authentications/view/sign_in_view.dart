import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/authentications/viewModel/auth_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

import '../../../custom_widget.dart';

class SignInView extends GetView<AuthViewModel> {
  static const signInView = '/signInView';

  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      assignId: true,
      builder: (logic) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SafeArea(
              bottom: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final minHeight = constraints.maxHeight;
                  final pageHeight = minHeight < 680.h ? 680.h : minHeight;
                  final sheetTop = pageHeight * 0.62;

                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: minHeight),
                      child: SizedBox(
                        height: pageHeight,
                        child: Stack(
                          children: [
                            Positioned(
                              top: (sheetTop - 148.h)
                                  .clamp(400.h, 470.h)
                                  .toDouble(),
                              left: 30.w,
                              right: 30.w,
                              child: const _WelcomeTitle(),
                            ),
                            Positioned(
                              top: (pageHeight * 0.18)
                                  .clamp(95.h, 220.h)
                                  .toDouble(),
                              left: 0,
                              right: 0,
                              child: const _LogoBadge(),
                            ),
                            Positioned(
                              top: sheetTop,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: _LoginSheet(controller: controller),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160.w,
        height: 160.w,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 0.785398,
              child: Container(
                width: 39.w,
                height: 39.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1.7.w,
                  ),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Transform.rotate(
                  angle: -0.785398,
                  child: Icon(
                    Icons.gps_fixed,
                    color: AppColors.primaryColor,
                    size: 28.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            CustomWidget.text(
              AppStrings.appName,
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return CustomWidget.text(
      AuthStrings.welcometext,
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }
}

class _LoginSheet extends StatelessWidget {
  const _LoginSheet({required this.controller});

  final AuthViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(37.w, 48.h, 37.w, 34.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomWidget.customTextFormField(
              hintText: AuthStrings.username,
              labelText: AuthStrings.username,
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
                        AuthStrings.delear,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            10.h.sizeBoxFromHeight(),
            Center(
              child: CustomWidget.customButton(
                callBack: controller.login,
                btnText: AuthStrings.login,
                borderRadius: 5.0,
                textSize: 15,
                color: AppColors.primaryColor,
                width: double.infinity,
                height: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
