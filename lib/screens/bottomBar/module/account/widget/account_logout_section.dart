import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class AccountLogoutSection extends GetView<AccountViewModel> {
  const AccountLogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          CustomWidget.customButton(
            callBack: controller.onLogout,
            btnText: AppStrings.logOut,
            borderRadius: 6.0,
            textColor: AppColors.whiteColor,
            textSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
            width: double.infinity,
            height: 48,
          ),
          16.h.sizeBoxFromHeight(),
          Obx(() {
            return CustomWidget.text(
              '${AppStrings.version} : ${controller.appVersion.value}',
              fontSize: 12,
              color: AppColors.grayColor,
              textAlign: TextAlign.center,
            );
          }),
        ],
      ),
    );
  }
}
