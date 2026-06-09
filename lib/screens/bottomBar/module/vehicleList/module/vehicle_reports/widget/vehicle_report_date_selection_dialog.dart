import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/report_date_selection_dialog_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';

class VehicleReportDateSelectionDialog extends GetView<VehicleListViewModel> {
  const VehicleReportDateSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReportDateSelectionDialogWidget(
        selectedDateRange: controller.selectedVehicleReportDateRange.value,
        onSelectDate: controller.selectVehicleReportDateRange,
        onClose: controller.onVehicleReportDateSelectionClose,
        onOk: controller.onVehicleReportDateSelectionOk,
      ),
    );
  }
}
