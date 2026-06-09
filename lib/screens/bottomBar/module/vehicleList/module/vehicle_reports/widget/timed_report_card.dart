import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selection_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class TimedReportCard extends StatelessWidget {
  const TimedReportCard({
    super.key,
    required this.report,
  });

  final TimedReportItem report;

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
              width: 9.w,
              color: AppColors.bgConatinerColor,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 5.h),
                child: Column(
                  children: [
                    CustomWidget.text(
                      report.date,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.reportTextColor,
                      textAlign: TextAlign.center,
                    ),
                    5.h.sizeBoxFromHeight(),
                    CustomWidget.text(
                      report.address,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.reportAddressTextColor,
                      textAlign: TextAlign.center,
                      maxLine: 4,
                    ),
                    5.h.sizeBoxFromHeight(),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: _timeSection(
                              time: report.startTime,
                              label: AppStrings.start,
                              labelColor: AppColors.textGreenColor,
                            ),
                          ),
                          Container(
                            width: 1,
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            color: AppColors.blackColor,
                          ),
                          Expanded(
                            child: _timeSection(
                              time: report.endTime,
                              label: AppStrings.end,
                              labelColor: AppColors.textRedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    5.h.sizeBoxFromHeight(),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.blackColor,
                    ),
                    5.h.sizeBoxFromHeight(),
                    CustomWidget.text(
                      report.duration,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.reportTextColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeSection({
    required String time,
    required String label,
    required Color labelColor,
  }) {
    return Column(
      children: [
        CustomWidget.text(
          time,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
          textAlign: TextAlign.center,
        ),
        CustomWidget.text(
          label,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: labelColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
