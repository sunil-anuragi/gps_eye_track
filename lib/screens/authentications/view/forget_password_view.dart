import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/authentications/viewModel/auth_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ForgetPasswordView extends GetView<AuthViewModel> {
  static const forgetPasswordView = '/forgetPasswordView';

  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      assignId: true,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: const Color(0xff404040),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.w),
              onPressed: () => Get.back(),
            ),
            title: CustomWidget.text(
              AuthStrings.gpsSoftware,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.h.sizeBoxFromHeight(),
                  // Screen Title
                  CustomWidget.text(
                    AuthStrings.forgetPasswordTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                  8.h.sizeBoxFromHeight(),
                  // Screen Subtitle
                  CustomWidget.text(
                    AuthStrings.forgetPasswordSubtitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtitleColor,
                    textAlign: TextAlign.center,
                  ),
                  20.h.sizeBoxFromHeight(),
                  // Illustration in the center
                  Image.asset(
                    Assets.assetsForgetPassword,
                    height: 180.h,
                    fit: BoxFit.contain,
                  ),
                  40.h.sizeBoxFromHeight(),
                  // User ID Input field
                  CustomWidget.customTextFormField(
                    hintText: AuthStrings.enterUserId,
                    labelText: AuthStrings.enterUserId,
                    controller: controller.userIdController,
                    isPrefixShow: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(
                        Icons.person,
                        size: 22.w,
                        color: AppColors.black87,
                      ),
                    ),
                  ),
                  40.h.sizeBoxFromHeight(),
                  // Continue button
                  CustomWidget.customButton(
                    callBack: controller.continueForgotPassword,
                    btnText: AuthStrings.continueBtn,
                    borderRadius: 24.0,
                    color: AppColors.primaryColor, // Dark grey
                    width: double.infinity,
                    height: 48,
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
