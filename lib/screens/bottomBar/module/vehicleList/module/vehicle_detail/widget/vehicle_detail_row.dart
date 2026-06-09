import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleDetailRow extends StatelessWidget {
  const VehicleDetailRow({
    super.key,
    required this.label,
    this.value,
    this.trailing,
    this.showDivider = true,
  });

  final String label;
  final String? value;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomWidget.text(
                label,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            if (trailing != null)
                trailing!
              else if (value != null)
                Expanded(
                  child: CustomWidget.text(
                    value!,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrayLightColor,
                    textAlign: TextAlign.end,
                    maxLine: 1,
                  ),
                ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerColor,
          ),
      ],
    );
  }
}
