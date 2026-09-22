import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/view/trip_report/trip_report_map_view.dart';
import 'package:gps_software/screens/reports/view/trip_report/widgets/trip_report_card.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

class TripReportView extends GetView<ReportViewModel> {
  const TripReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemSpacing: 18,
      itemBuilder: (context, item, index) => TripReportCard(
        item: item as TripReportItem,
        onTap: () => Get.toNamed(
          TripReportMapView.tripReportMapView,
          arguments: {'item': item},
        ),
      ),
    );
  }
}
