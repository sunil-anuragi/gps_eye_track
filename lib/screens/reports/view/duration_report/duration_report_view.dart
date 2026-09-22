import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

class DurationReportView extends GetView<ReportViewModel> {
  const DurationReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemBuilder: (context, item, index) {
        final entry = item as DurationReportItem;
        return ReportCard(
          sidePanel: ReportPanelValue(
            value: entry.distanceKm.toStringAsFixed(2),
            unit: 'Km',
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _time(entry.start, ReportColors.startDot),
              const ReportDivider(),
              _time(entry.end, ReportColors.endDot),
            ],
          ),
        );
      },
    );
  }

  Widget _time(DateTime time, Color color) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 12.h, 10.w, 12.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ReportIconText(
          icon: Icons.edit_calendar,
          iconColor: color,
          text: ReportViewModel.fullFormat.format(time),
        ),
      ),
    );
  }
}
