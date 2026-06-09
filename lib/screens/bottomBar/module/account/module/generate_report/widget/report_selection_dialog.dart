import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_dialog_search_bar.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selection_card.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ReportSelectionDialog extends GetView<AccountViewModel> {
  const ReportSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.7.sh),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReportDialogSearchBar(
              controller: controller.reportSearchController,
              onChanged: controller.onReportSearchChanged,
            ),
            16.h.sizeBoxFromHeight(),
            Flexible(
              child: Obx(() {
                final items = controller.filteredReportSelectionItems;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ReportSelectionCard(
                      label: item,
                      icon: controller.reportSelectionDialogType ==
                              ReportSelectionDialogType.reportType
                          ? controller.getReportTypeIcon(item)
                          : null,
                      onTap: () => controller.onReportItemSelected(item),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
