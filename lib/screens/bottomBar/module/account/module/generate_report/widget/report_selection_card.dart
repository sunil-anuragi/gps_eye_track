import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class ReportSelectionCard extends StatelessWidget {
  const ReportSelectionCard({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final String? icon;

  static List<BoxShadow> get elevationShadows => [
        BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: BouncingWidget(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: elevationShadows,
          ),
          child: CustomWidget.text(
            label,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
