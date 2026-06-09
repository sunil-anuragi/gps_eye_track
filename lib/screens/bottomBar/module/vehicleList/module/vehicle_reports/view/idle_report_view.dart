import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/timed_report_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/vehicle_report_app_bar_actions.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class IdleReportView extends GetView<VehicleListViewModel> {
  static const idleReportView = '/idleReportView';

  const IdleReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBgColor,
      appBar: AccountModuleAppBar(
        title: AppStrings.idleReport,
        action: VehicleReportAppBarActions(
          onDownload: controller.onIdleReportDownload,
          onCalendar: controller.showVehicleReportDateSelectionDialog,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
        itemCount: controller.idleReportItems.length,
        itemBuilder: (context, index) {
          return TimedReportCard(report: controller.idleReportItems[index]);
        },
      ),
    );
  }
}
