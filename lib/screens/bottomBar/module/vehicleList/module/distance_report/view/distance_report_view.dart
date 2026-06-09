import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/distance_report/widget/distance_report_card.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/vehicle_report_app_bar_actions.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class DistanceReportView extends GetView<VehicleListViewModel> {
  static const distanceReportView = '/distanceReportView';

  const DistanceReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBgColor,
      appBar: AccountModuleAppBar(
        title: AppStrings.distanceReport,
        action: VehicleReportAppBarActions(
          onDownload: controller.onDistanceReportDownload,
          onCalendar: controller.showVehicleReportDateSelectionDialog,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.searchBgColor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: CustomWidget.text(
              '${AppStrings.totalDistance} ${controller.totalDistanceValue}',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
              itemCount: controller.distanceReportItems.length,
              itemBuilder: (context, index) {
                return DistanceReportCard(
                  report: controller.distanceReportItems[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
