import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
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
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.searchBgColor,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              size: 36.r,
              color: AppColors.grayColor,
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                  4.h.sizeBoxFromHeight(),
                  CustomWidget.text(
                    controller.userName.value,
                    fontSize: 14,
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
