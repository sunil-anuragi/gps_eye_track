import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleMenuTile extends StatelessWidget {
  const VehicleMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingValue,
    this.onTap,
    this.showDivider = true,
  });

  final String icon;
  final String title;
  final String? trailingValue;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 22.r,
                  height: 22.r,
                  fit: BoxFit.contain,
                ),
                16.w.sizeBoxFromWidth(),
                Expanded(
                  child: CustomWidget.text(
                    title,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ),
                if (trailingValue != null) ...[
                  CustomWidget.text(
                    trailingValue!,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtitleColor,
                  ),
                  8.w.sizeBoxFromWidth(),
                ],
                Image.asset(
                  Assets.icArrow,
                  width: 8.r,
                  height: 13.r,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.menuDividerColor,
          ),
      ],
    );
  }
}
