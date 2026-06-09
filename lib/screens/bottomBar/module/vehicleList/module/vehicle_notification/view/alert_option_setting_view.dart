import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/widget/notification_switch_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class AlertOptionSettingView extends GetView<VehicleListViewModel> {
  static const alertOptionSettingView = '/alertOptionSettingView';

  const AlertOptionSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AccountModuleAppBar(
        title: AppStrings.chaseTrack,
        action: TextButton(
          onPressed: controller.onAlertOptionSave,
          child: CustomWidget.text(
            AppStrings.save,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: 
      // Obx(
      //   () =>
        
         ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: controller.alertOptions.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            thickness: 1,
            color: AppColors.menuDividerColor,
          ),
          itemBuilder: (context, index) {
            final option = controller.alertOptions[index];
            return NotificationSwitchTile(
              title: option.title,
              value: option.enabled.value,
              onChanged: (value) =>
                  controller.onAlertOptionChanged(index, value),
              showDivider: false,
            );
          },
        ),
      // ),
    );
  }
}
