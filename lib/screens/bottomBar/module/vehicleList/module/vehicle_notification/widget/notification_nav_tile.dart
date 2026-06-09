import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/util/app_constant.dart';

class NotificationNavTile extends StatelessWidget {
  const NotificationNavTile({
    super.key,
    required this.title,
    this.onTap,
    this.showDivider = false,
  });

  final String title;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
       
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomWidget.text(
                      title,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Image.asset(
                    Assets.icArrow,
                    width: 8.r,
                    height: 15.r,
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
      ),
    );
  }
}
