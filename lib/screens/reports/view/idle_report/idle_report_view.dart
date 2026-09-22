import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/view/stop_report/stop_report_map_view.dart';
import 'package:gps_software/screens/reports/view/stop_report/widgets/stop_report_card.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

/// Idle report: same layout as the stop report
class IdleReportView extends GetView<ReportViewModel> {
  const IdleReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      floatingActionButton: Obx(
        () => controller.items.isEmpty
            ? const SizedBox.shrink()
            : ReportMapFab(
                onTap: () => Get.toNamed(StopReportMapView.stopReportMapView),
              ),
      ),
      itemBuilder: (context, item, index) => StopReportCard(
        item: item as StopReportItem,
        onTap: () => Get.toNamed(
          StopReportMapView.stopReportMapView,
          arguments: {'selected': index},
        ),
      ),
    );
  }
}
