import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class AccountProfileHeader extends GetView<AccountViewModel> {
  const AccountProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          Container(
            width: 61.r,
            height: 61.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withValues(alpha: 0.25),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                Assets.assetsAccount,
                height: 40.r,
                width: 40.r,
              ),
            ),
          ),
          16.w.sizeBoxFromWidth(),
          Expanded(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWidget.text(
                    AppStrings.userNameLabel,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  2.h.sizeBoxFromHeight(),
                  CustomWidget.text(
                    controller.userName.value,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
