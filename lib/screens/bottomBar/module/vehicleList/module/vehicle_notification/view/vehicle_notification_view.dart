import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/widget/notification_nav_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/widget/notification_switch_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleNotificationView extends GetView<VehicleListViewModel> {
  static const vehicleNotificationView = '/vehicleNotificationView';

  const VehicleNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBgColor,
      appBar: const AccountModuleAppBar(title: AppStrings.chaseTrack),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NotificationSwitchTile(
              title: AppStrings.receiveNotification,
              value: controller.receiveNotificationEnabled.value,
              onChanged: controller.onReceiveNotificationChanged,
            ),
            20.h.sizeBoxFromHeight(),
            NotificationSwitchTile(
              title: AppStrings.voiceNotification,
              value: controller.voiceNotificationEnabled.value,
              onChanged: controller.onVoiceNotificationChanged,
            ),
            20.h.sizeBoxFromHeight(),
            NotificationNavTile(
              title: AppStrings.alertOptionSetting,
              onTap: controller.onAlertOptionSettingTap,
              showDivider: true,
            ),
          ],
        ),
      ),
    );
  }
}
