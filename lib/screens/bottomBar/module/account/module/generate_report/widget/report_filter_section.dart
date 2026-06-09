import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selector_field.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ReportFilterSection extends GetView<AccountViewModel> {
  const ReportFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.reportFilterBgColor,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
      child: Obx(() {
        return Column(
          children: [
            ReportSelectorField(
              placeholder: AppStrings.selectVehicle,
              value: controller.selectedReportVehicle.value.isEmpty
                  ? null
                  : controller.selectedReportVehicle.value,
              onTap: controller.showVehicleSelectionDialog,
            ),
            12.h.sizeBoxFromHeight(),
            ReportSelectorField(
              placeholder: AppStrings.selectReportType,
              value: controller.selectedReportType.value.isEmpty
                  ? null
                  : controller.selectedReportType.value,
              onTap: controller.showReportTypeSelectionDialog,
            ),
            16.h.sizeBoxFromHeight(),
            CustomWidget.customButton(
              callBack: controller.onGenerateReportSearch,
              btnText: AppStrings.searchPlaceholder,
              width: double.infinity,
              height: 48,
              borderRadius: 2.0,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
              textSize: 12.0,
            ),
          ],
        );
      }),
    );
  }
}
