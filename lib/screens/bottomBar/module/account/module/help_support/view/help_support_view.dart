import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/widget/contact_info_card.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/widget/support_action_row.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/widget/support_header_section.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/widget/support_illustration_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/util/app_constant.dart';

class HelpSupportView extends GetView<AccountViewModel> {
  static const helpSupportView = '/helpSupportView';

  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const AccountModuleAppBar(title: AppStrings.gpsSoftware),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SupportHeaderSection(),
            SupportIllustrationWidget(),
            ContactInfoCard(),
            18.h.sizeBoxFromHeight(),
            SupportActionRow(),
          ],
        ),
      ),
    );
  }
}
