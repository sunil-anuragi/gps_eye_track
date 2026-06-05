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
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidget.text(
            AppStrings.contactInformation,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
          12.h.sizeBoxFromHeight(),
          CustomWidget.text(
            '${AppStrings.mobile}: ${AppStrings.supportMobile}',
            fontSize: 13,
            color: AppColors.blackColor,
          ),
          8.h.sizeBoxFromHeight(),
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
