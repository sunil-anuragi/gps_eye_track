import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_result_card.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';

class ReportResultList extends GetView<AccountViewModel> {
  const ReportResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.showReportResults.value) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
        itemCount: controller.reportResults.length,
        itemBuilder: (context, index) {
          return ReportResultCard(report: controller.reportResults[index]);
        },
      );
    });
  }
}
