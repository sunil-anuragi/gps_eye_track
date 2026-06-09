import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selection_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class DistanceReportCard extends StatelessWidget {
  const DistanceReportCard({
    super.key,
    required this.report,
  });

  final DistanceReportItem report;

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  5.h.sizeBoxFromHeight(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16.r,
                          color: AppColors.iconGrayColor,
                        ),
                        8.w.sizeBoxFromWidth(),
                        CustomWidget.text(
                          report.date,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.dividerColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 5.h),
                    child: _routeSection(),
                  ),
                ],
              ),
            ),
            Container(
              width: 72.w,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              color: AppColors.primaryColor,
              child: CustomWidget.text(
                report.distance,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _routeSection() {
    return Row(
  
      children: [
        Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _dot(color: AppColors.textGreenColor),
            Container(
              width: 2,
              height: 40.h,
              color: AppColors.dividerColor,
            ),
            _dot(color: AppColors.textRedColor),
          ],
        ),
        8.w.sizeBoxFromWidth(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidget.text(
                report.startAddress,
                fontSize: 10,
                color: AppColors.blackColor,
                maxLine:2 ,
              ),
              10.h.sizeBoxFromHeight(),
              CustomWidget.text(
                report.endAddress,
                fontSize: 10,
                color: AppColors.blackColor,
                maxLine: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot({required Color color}) {
    return Container(
      width: 10.r,
      height: 10.r,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
