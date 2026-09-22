import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/change_password/viewModel/change_password_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ChangePasswordView extends GetView<ChangePasswordViewModel> {
  static const changePasswordView = '/changePasswordView';

  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const TrackingAppBar(title: 'Change Password'),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              Assets.changePasswordIllustration,
              height: 190.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 34.h),
            _PasswordField(
              hint: 'Enter Old Password',
              controller: controller.oldController,
              obscure: controller.obscureOld,
              action: TextInputAction.next,
            ),
            SizedBox(height: 14.h),
            _PasswordField(
              hint: 'Enter New Password',
              controller: controller.newController,
              obscure: controller.obscureNew,
              action: TextInputAction.next,
            ),
            SizedBox(height: 14.h),
            _PasswordField(
              hint: 'Confirm Password',
              controller: controller.confirmController,
              obscure: controller.obscureConfirm,
              action: TextInputAction.done,
              onSubmitted: controller.submit,
            ),
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SizedBox(
                height: 44.h,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TrackingColors.brandBlue,
                      disabledBackgroundColor:
                          TrackingColors.brandBlue.withValues(alpha: 0.6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r)),
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            width: 18.r,
                            height: 18.r,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.whiteColor),
                          )
                        : CustomWidget.text(
                            'Submit',
                            color: AppColors.whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.hint,
    required this.controller,
    required this.obscure,
    required this.action,
    this.onSubmitted,
  });

  final String hint;
  final TextEditingController controller;
  final RxBool obscure;
  final TextInputAction action;
  final VoidCallback? onSubmitted;

  static const Color _grey = Color(0xff6f6f6f);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide.none,
    );

    return Obx(
      () => TextField(
        controller: controller,
        obscureText: obscure.value,
        textInputAction: action,
        onSubmitted: onSubmitted == null ? null : (_) => onSubmitted!(),
        style: TextStyle(fontSize: 14.sp, fontFamily: 'Dmsans'),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xff7a7a7a),
            fontFamily: 'Dmsans',
          ),
          filled: true,
          fillColor: const Color(0xffdcdcdc),
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 10.w),
            child: Icon(Icons.lock, color: _grey, size: 20.r),
          ),
          suffixIcon: IconButton(
            onPressed: () => obscure.toggle(),
            icon: Icon(
              obscure.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: _grey,
              size: 20.r,
            ),
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide:
                const BorderSide(color: TrackingColors.brandBlue, width: 1.2),
          ),
        ),
      ),
    );
  }
}
