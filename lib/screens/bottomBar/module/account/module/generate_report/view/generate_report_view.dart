import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_filter_section.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_result_list.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/util/app_constant.dart';

class GenerateReportView extends GetView<AccountViewModel> {
  static const generateReportView = '/generateReportView';

  const GenerateReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      appBar: const AccountModuleAppBar(title: AppStrings.chaseTrack),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReportFilterSection(),
          Expanded(child: ReportResultList()),
        ],
      ),
    );
  }
}
