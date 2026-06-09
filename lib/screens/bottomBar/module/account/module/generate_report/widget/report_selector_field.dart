import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class ReportSelectorField extends StatelessWidget {
  const ReportSelectorField({
    super.key,
    required this.placeholder,
    required this.value,
    required this.onTap,
  });

  final String placeholder;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;

    return BouncingWidget(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.reportSelectorBgColor,
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomWidget.text(
                hasValue ? value! : placeholder,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: hasValue ? AppColors.blackColor : AppColors.grayColor,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.iconGrayColor,
              size: 24.r,
            ),
          ],
        ),
      ),
    );
  }
}
