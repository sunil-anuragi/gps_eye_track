import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_logout_section.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_menu_tile.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_profile_header.dart';
import 'package:gps_software/screens/bottomBar/widget/tab_app_bar.dart';
import 'package:gps_software/util/app_constant.dart';

class AccountView extends GetView<AccountViewModel> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const TabAppBar(title: AppStrings.me),
      body: Column(
        children: [
          const AccountProfileHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.menuItems.length,
              itemBuilder: (context, index) {
                final item = controller.menuItems[index];
                return AccountMenuTile(
                  item: item,
                  onTap: () => controller.onMenuTap(item.title),
                );
              },
            ),
          ),
          const AccountLogoutSection(),
        ],
      ),
    );
  }
}
