import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selection_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceReportCard extends StatelessWidget {
  const GeofenceReportCard({
    super.key,
    required this.report,
  });

  final GeofenceReportItem report;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: ReportSelectionCard.elevationShadows,
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 72.w,
              color: AppColors.primaryColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Image.asset(
                Assets.geofenceReportIcon,
                width: 44.r,
                height: 44.r,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomWidget.text(
                    report.vehicleId,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.subtitleColor,
                  ).paddingOnly(left: 12.w,right: 12.w,top: 12.h),
                  6.h.sizeBoxFromHeight(),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.dividerColor,
                  ),
                  6.h.sizeBoxFromHeight(),
                  CustomWidget.text(
                    report.dateTime,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text1Color,
                  ).paddingOnly(left: 12.w,right: 12.w),
                  4.h.sizeBoxFromHeight(),
                  CustomWidget.text(
                    report.address,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtitleColor,
                    maxLine: 3,
                  ).paddingOnly(left: 12.w,right: 12.w,bottom: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
