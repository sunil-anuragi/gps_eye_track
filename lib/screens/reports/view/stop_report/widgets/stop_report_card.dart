import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

/// Card used by the stop, idle and AC reports:
/// date + duration, address, and start / end time on the navy panel.
class StopReportCard extends StatelessWidget {
  const StopReportCard({
    super.key,
    required this.item,
    this.onTap,
    this.startLabel = 'Start Time',
    this.endLabel = 'End Time',
    this.elevated = false,
  });

  final StopReportItem item;
  final VoidCallback? onTap;
  final String startLabel;
  final String endLabel;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return ReportCard(
      onTap: onTap,
      elevated: elevated,
      sidePanel: ReportPanelTimes(
        start: item.start,
        end: item.end,
        startLabel: startLabel,
        endLabel: endLabel,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(22.w, 12.h, 10.w, 10.h),
            child: Row(
              children: [
                Expanded(
                  child: ReportIconText(
                    asset: Assets.reportCardCalendar,
                    text: ReportViewModel.dayFormat.format(item.start),
                  ),
                ),
                ReportIconText(
                  asset: Assets.reportCardClock,
                  text: ReportViewModel.formatDuration(item.duration),
                ),
              ],
            ),
          ),
          const ReportDivider(),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 14.h),
            child: Row(
              children: [
                Image.asset(Assets.reportCardLocation,
                    width: 26.r, height: 26.r, fit: BoxFit.contain),
                SizedBox(width: 12.w),
                Expanded(child: ReportAddress(item.location)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
