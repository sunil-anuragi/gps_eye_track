import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/vehicle_report_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleReportsView extends GetView<VehicleListViewModel> {
  static const vehicleReportsView = '/vehicleReportsView';

  const VehicleReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      if (vehicle == null) {
        return const Scaffold(body: SizedBox.shrink());
      }

      final reports = controller.vehicleReportItems;

      return Scaffold(
        backgroundColor: AppColors.containerBgColor,
        appBar: AccountModuleAppBar(title: vehicle.vehicleId),
        body: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            return VehicleReportTile(
              icon: report.icon,
              title: report.title,
              showDivider: index < reports.length ,
              onTap: () => controller.onVehicleReportTap(report.title),
            );
          },
        ),
      );
    });
  }
}
