import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

class MovementReportView extends GetView<ReportViewModel> {
  const MovementReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      showTotalDistance: true,
      itemBuilder: (context, item, index) =>
          _MovementCard(item: item as MovementReportItem),
    );
  }
}

class _MovementCard extends StatelessWidget {
  const _MovementCard({required this.item});

  final MovementReportItem item;

  @override
  Widget build(BuildContext context) {
    return ReportCard(
      sidePanel: ReportPanelValue(
        value: item.distanceKm.toStringAsFixed(1),
        unit: 'Km',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _point(item.start, item.from, ReportColors.startDot),
          const ReportDivider(),
          _point(item.end, item.to, ReportColors.endDot),
        ],
      ),
    );
  }

  Widget _point(DateTime time, ReportLocation location, Color color) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 10.h, 10.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportIconText(
            icon: Icons.edit_calendar,
            iconColor: color,
            text: ReportViewModel.fullFormat.format(time),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              SizedBox(
                width: 20.r,
                child: Center(
                  child: Container(
                    width: 12.r,
                    height: 12.r,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(child: ReportAddress(location)),
            ],
          ),
        ],
      ),
    );
  }
}
