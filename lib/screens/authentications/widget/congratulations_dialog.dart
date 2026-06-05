import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/authentications/view/sign_in_view.dart';
import 'package:gps_software/util/app_constant.dart';

class CongratulationsDialog extends StatelessWidget {
  const CongratulationsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.assetsPhone,
              height: 120.h,
              fit: BoxFit.contain,
            ),
            16.h.sizeBoxFromHeight(),
            CustomWidget.text(
              AuthStrings.congratulations,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
            8.h.sizeBoxFromHeight(),
            CustomWidget.text(
              AuthStrings.successSubtitle,
              fontSize: 14,
              color: AppColors.subtitleColor,
              textAlign: TextAlign.center,
            ),
            24.h.sizeBoxFromHeight(),
            CustomWidget.customButton(
              callBack: () {
                Get.back();
                Get.offAllNamed(SignInView.signInView);
              },
              btnText: AuthStrings.goToLogin,
              borderRadius: 24.0,
              color: AppColors.primaryColor,
              width: double.infinity,
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
