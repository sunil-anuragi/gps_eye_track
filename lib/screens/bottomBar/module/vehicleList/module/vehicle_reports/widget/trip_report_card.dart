import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selection_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class TripReportCard extends StatelessWidget {
  const TripReportCard({
    super.key,
    required this.report,
  });

  final VehicleTripReportItem report;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: ReportSelectionCard.elevationShadows,
        border: Border(
          left: BorderSide(
            color: AppColors.cardBorderColor,
            width: 10.w,
          ),
        ),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _locationSection(
                    address: report.startAddress,
                    time: report.startTime,
                    label: AppStrings.start,
                    labelColor: AppColors.textGreenColor,
                  ),
                ),
                Container(
                  width: 1,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  color: AppColors.blackColor,
                ),
                Expanded(
                  child: _locationSection(
                    address: report.endAddress,
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
          10.h.sizeBoxFromHeight(),
          Row(
            children: [
              Expanded(
                child: _statColumn(
                  value: report.avgSpeed,
                  label: AppStrings.avgSpeed,
                ),
              ),
              Expanded(
                child: _statColumn(
                  value: report.duration,
                  label: AppStrings.duration,
                ),
              ),
              Expanded(
                child: _statColumn(
                  value: report.maxSpeed,
                  label: AppStrings.maxSpeed,
                ),
              ),
              Expanded(
                child: _statColumn(
                  value: report.distance,
                  label: AppStrings.distance,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _locationSection({
    required String address,
    required String time,
    required String label,
    required Color labelColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomWidget.text(
          address,
          fontSize: 10,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w400,
          maxLine: 4,
          textAlign: TextAlign.center,
        ),
        6.h.sizeBoxFromHeight(),
        CustomWidget.text(
          time,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        CustomWidget.text(
          label,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: labelColor,
        ),
      ],
    );
  }

  Widget _statColumn({
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        CustomWidget.text(
          value,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
          textAlign: TextAlign.center,
        ),
      
        CustomWidget.text(
          label,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: AppColors.textGreenColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
