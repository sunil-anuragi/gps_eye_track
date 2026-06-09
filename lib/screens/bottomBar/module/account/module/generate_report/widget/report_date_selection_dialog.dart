import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/report_date_selection_dialog_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';

class ReportDateSelectionDialog extends GetView<AccountViewModel> {
  const ReportDateSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReportDateSelectionDialogWidget(
        selectedDateRange: controller.selectedDateRange.value,
        onSelectDate: controller.selectDateRange,
        onClose: controller.onDateSelectionClose,
        onOk: controller.onDateSelectionOk,
      ),
    );
  }
}
