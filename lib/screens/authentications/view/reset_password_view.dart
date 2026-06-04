import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/authentications/viewModel/auth_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ResetPasswordView extends GetView<AuthViewModel> {
  static const resetPasswordView = '/resetPasswordView';

  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      assignId: true,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.h.sizeBoxFromHeight(),
                  // Screen Title
                  CustomWidget.text(
                    AuthStrings.resetPasswordTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                  8.h.sizeBoxFromHeight(),
                  // Screen Subtitle
                  CustomWidget.text(
                    AuthStrings.resetPasswordSubtitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtitleColor,
                    textAlign: TextAlign.center,
                  ),
                  40.h.sizeBoxFromHeight(),
                  // Option Selection Row (Email)
                  Obx(
                    () => InkWell(
                      onTap: () => controller.selectResetMethod('email'),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Transform.scale(
                                scale: 0.85,
                                child: Radio<String>(
                                  value: 'email',
                                  groupValue:
                                      controller.selectedResetMethod.value,
                                  onChanged: (value) =>
                                      controller.selectResetMethod(value!),
                                  activeColor: Colors.black,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                            8.w.sizeBoxFromWidth(),
                            Expanded(
                              child: Row(
                                children: [
                                  CustomWidget.text(
                                    "Register Email Id :",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff3f51b5),
                                  ),
                                  8.w.sizeBoxFromWidth(),
                                  Expanded(
                                    child: CustomWidget.text(
                                      "ac***********@gmail.com",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.h.sizeBoxFromHeight(),
                  // Option Selection Row (Phone)
                  Obx(
                    () => InkWell(
                      onTap: () => controller.selectResetMethod('phone'),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Transform.scale(
                                scale: 0.85,
                                child: Radio<String>(
                                  value: 'phone',
                                  groupValue:
                                      controller.selectedResetMethod.value,
                                  onChanged: (value) =>
                                      controller.selectResetMethod(value!),
                                  activeColor: Colors.black,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                            8.w.sizeBoxFromWidth(),
                            Expanded(
                              child: Row(
                                children: [
                                  CustomWidget.text(
                                    "Register Mobile No :",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff3f51b5),
                                  ),
                                  8.w.sizeBoxFromWidth(),
                                  Expanded(
                                    child: CustomWidget.text(
                                      "**********7078",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Continue button
                  CustomWidget.customButton(
                    callBack: () => controller.resetPassword(context),
                    btnText: AuthStrings.continueBtn,
                    borderRadius: 24.0,
                    color: AppColors.primaryColor, // Dark grey
                    width: double.infinity,
                    height: 48,
                  ),
                  30.h.sizeBoxFromHeight(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
