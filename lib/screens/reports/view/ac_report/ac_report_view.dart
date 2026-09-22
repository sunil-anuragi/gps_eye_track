import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/view/stop_report/stop_report_map_view.dart';
import 'package:gps_software/screens/reports/view/stop_report/widgets/stop_report_card.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

/// AC report: AC ON periods, shown with the stop card layout
class AcReportView extends GetView<ReportViewModel> {
  const AcReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemBuilder: (context, item, index) => StopReportCard(
        item: item as StopReportItem,
        startLabel: 'ON Time',
        endLabel: 'OFF Time',
        onTap: () => Get.toNamed(
          StopReportMapView.stopReportMapView,
          arguments: {'selected': index},
        ),
      ),
    );
  }
}
