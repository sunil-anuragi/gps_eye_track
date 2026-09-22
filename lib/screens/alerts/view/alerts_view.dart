import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/alerts/view/alert_map_view.dart';
import 'package:gps_software/screens/alerts/viewModel/alerts_view_model.dart';
import 'package:gps_software/screens/alerts/widgets/alert_card.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';

class AlertsView extends GetView<AlertsViewModel> {
  static const alertsView = '/alertsView';

  const AlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReportColors.background,
      appBar: ReportAppBar(title: controller.vehicleNo),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: ReportColors.panel),
          );
        }
        if (controller.alerts.isEmpty) {
          return Center(
            child: CustomWidget.text(
              'No alerts found',
              color: ReportColors.greyText,
              fontSize: 14,
              letterSpacing: 0,
            ),
          );
        }
        return RefreshIndicator(
          color: ReportColors.panel,
          onRefresh: controller.loadAlerts,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 30.h),
            itemCount: controller.alerts.length,
            separatorBuilder: (_, __) => SizedBox(height: 14.h),
            itemBuilder: (_, index) {
              final alert = controller.alerts[index];
              return AlertCard(
                alert: alert,
                onTap: () => Get.toNamed(
                  AlertMapView.alertMapView,
                  arguments: alert,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
