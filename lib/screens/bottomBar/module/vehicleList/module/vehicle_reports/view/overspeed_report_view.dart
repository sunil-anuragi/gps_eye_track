import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/overspeed_report_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/vehicle_report_app_bar_actions.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class OverspeedReportView extends GetView<VehicleListViewModel> {
  static const overspeedReportView = '/overspeedReportView';

  const OverspeedReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBgColor,
      appBar: AccountModuleAppBar(
        title: AppStrings.overspeedReport,
        action: VehicleReportAppBarActions(
          onDownload: controller.onOverspeedReportDownload,
          onCalendar: controller.showVehicleReportDateSelectionDialog,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
        itemCount: controller.overspeedReportItems.length,
        itemBuilder: (context, index) {
          return OverspeedReportCard(
            report: controller.overspeedReportItems[index],
          );
        },
      ),
    );
  }
}
