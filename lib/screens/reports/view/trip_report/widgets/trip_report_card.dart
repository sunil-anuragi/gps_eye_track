import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Card used by the trip and overspeed reports: date, four metric chips
/// joined to a navy box with the start / end times and addresses.
class TripReportCard extends StatelessWidget {
  const TripReportCard({
    super.key,
    required this.item,
    this.isOverspeed = false,
    this.onTap,
  });

  final TripReportItem item;
  final bool isOverspeed;
  final VoidCallback? onTap;

  List<MapEntry<String, String>> get _metrics {
    String speed(double v) => '${v.toStringAsFixed(1)}KM';
    final duration = ReportViewModel.formatDuration(item.duration);
    final distance = '${item.distanceKm.toStringAsFixed(2)}KM';
    return isOverspeed
        ? [
            MapEntry(speed(item.startSpeed), 'Start Speed'),
            MapEntry(duration, 'Duration'),
            MapEntry(speed(item.endSpeed), 'End Speed'),
            MapEntry(distance, 'Distance'),
          ]
        : [
            MapEntry(speed(item.avgSpeed), 'Avg Speed'),
            MapEntry(duration, 'Duration'),
            MapEntry(speed(item.maxSpeed), 'Max Speed'),
            MapEntry(distance, 'Distance'),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomWidget.text(
                  ReportViewModel.isoDayFormat.format(item.start),
                  fontSize: 14,
                  letterSpacing: 0,
                ),
                SizedBox(width: 8.w),
                Icon(Icons.calendar_month,
                    color: const Color(0xff9aa6b2), size: 22.r),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: _metrics.map((m) {
                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ReportColors.panel,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: [
                              CustomWidget.text(m.key,
                                  color: AppColors.whiteColor,
                                  fontSize: 10,
                                  letterSpacing: 0),
                              CustomWidget.text(m.value,
                                  color: AppColors.whiteColor,
                                  fontSize: 12,
                                  letterSpacing: 0),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          width: 1.2, height: 18.h, color: ReportColors.text),
                    ],
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
              decoration: BoxDecoration(
                color: ReportColors.panel,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: ReportRouteTimeline(
                from: item.from,
                to: item.to,
                textColor: AppColors.whiteColor,
                lineColor: AppColors.whiteColor,
                startTime: ReportViewModel.timeFormat.format(item.start),
                endTime: ReportViewModel.timeFormat.format(item.end),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
