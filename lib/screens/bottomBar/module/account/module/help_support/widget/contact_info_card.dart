import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidget.text(
            AppStrings.contactInformation,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          12.h.sizeBoxFromHeight(),
          CustomWidget.text(
            '${AppStrings.mobile}: ${AppStrings.supportMobile}',
            fontSize: 13,
            color: AppColors.blackColor,
          ),
          3.h.sizeBoxFromHeight(),
          CustomWidget.text(
            '${AppStrings.email} : ${AppStrings.supportEmail}',
            fontSize: 13,
            color: AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
