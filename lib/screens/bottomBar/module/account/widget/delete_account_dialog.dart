import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class DeleteAccountDialog extends GetView<AccountViewModel> {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.text(
              AppStrings.deleteAccount,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
            16.h.sizeBoxFromHeight(),
            CustomWidget.text(
              AppStrings.deleteAccountMessage,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.subtitleColor,
              textAlign: TextAlign.center,
            ),
            28.h.sizeBoxFromHeight(),
            Row(
              children: [
                Expanded(
                  child: _dialogButton(
                    label: AppStrings.cancelUpper,
                    onTap: controller.onDeleteAccountCancel,
                  ),
                ),
                16.w.sizeBoxFromWidth(),
                Expanded(
                  child: _dialogButton(
                    label: AppStrings.confirmUpper,
                    onTap: controller.onDeleteAccountConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: CustomWidget.text(
            label,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
