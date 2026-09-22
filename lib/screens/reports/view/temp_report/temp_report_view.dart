import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Temperature readings: time + location with the reading on the navy panel
class TempReportView extends GetView<ReportViewModel> {
  const TempReportView({super.key});

  static const double _highTemp = 27;

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemBuilder: (context, item, index) {
        final reading = item as TempReportItem;
        final isHigh = reading.temperature > _highTemp;
        return ReportCard(
          sidePanel: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Icon(Icons.thermostat,
                    color: isHigh ? const Color(0xffff8a80) : Colors.white,
                    size: 26.r),
                CustomWidget.text(
                  '${reading.temperature.toStringAsFixed(1)}°C',
                  color: AppColors.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 12.h, 10.w, 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ReportIconText(
                    icon: Icons.calendar_month,
                    text: ReportViewModel.fullFormat.format(reading.time),
                  ),
                ),
              ),
              const ReportDivider(),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 14.h),
                child: Row(
                  children: [
                    Icon(Icons.location_on,
                        color: ReportColors.endDot, size: 26.r),
                    SizedBox(width: 12.w),
                    Expanded(child: ReportAddress(reading.location)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
