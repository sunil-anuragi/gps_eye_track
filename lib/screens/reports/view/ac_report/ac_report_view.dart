import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

/// AC report: date, the route driven with the AC on, and the distance covered
class AcReportView extends GetView<ReportViewModel> {
  const AcReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemBuilder: (context, item, index) =>
          _AcCard(item: item as AcReportItem),
    );
  }
}

class _AcCard extends StatelessWidget {
  const _AcCard({required this.item});

  final AcReportItem item;

  @override
  Widget build(BuildContext context) {
    return ReportCard(
      sidePanelWidth: 80,
      sidePanel: ReportPanelValue(
        value: item.distanceKm.toStringAsFixed(2),
        unit: 'KM',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(22.w, 12.h, 10.w, 10.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ReportIconText(
                asset: Assets.reportCardCalendar,
                text: ReportViewModel.isoDayFormat.format(item.date),
                fontSize: 14,
              ),
            ),
          ),
          const ReportDivider(),
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 10.h, 10.w, 12.h),
            child: ReportRouteTimeline(from: item.from, to: item.to),
          ),
        ],
      ),
    );
  }
}
