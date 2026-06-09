import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ShareLocationTile extends StatelessWidget {
  const ShareLocationTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final ShareLocationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomWidget.text(
                item.shareId,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
            Expanded(
              flex: 4,
              child: CustomWidget.text(
                item.validTill,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomWidget.text(
                item.status,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
                textAlign: TextAlign.end,
              ),
            ),
            6.w.sizeBoxFromWidth(),
            Image.asset(
              Assets.icArrow,
              width: 8.r,
              height: 13.r,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
