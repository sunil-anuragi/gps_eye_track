import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class SupportHeaderSection extends StatelessWidget {
  const SupportHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          14.h.sizeBoxFromHeight(),
          CustomWidget.text(
            AppStrings.weAreHappyToHelp,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
          12.h.sizeBoxFromHeight(),
          CustomWidget.text(
            AppStrings.supportSubtitle,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
