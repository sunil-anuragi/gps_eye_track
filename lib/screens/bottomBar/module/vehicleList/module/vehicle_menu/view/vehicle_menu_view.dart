import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_menu/widget/vehicle_menu_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleMenuView extends GetView<VehicleListViewModel> {
  static const vehicleMenuView = '/vehicleMenuView';

  const VehicleMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      if (vehicle == null) {
        return const Scaffold(
          body: SizedBox.shrink(),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.screenBgColor,
        appBar: AccountModuleAppBar(title: vehicle.vehicleId),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              20.h.sizeBoxFromHeight(),
              _menuSection(
                children: [
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuImei,
                    title: AppStrings.imei,
                    trailingValue: vehicle.imei,
                    onTap: () => controller.onVehicleMenuTap(AppStrings.imei),
                  ),
                ],
              ),
              20.h.sizeBoxFromHeight(),
              _menuSection(
                children: [
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuTracking,
                    title: AppStrings.tracking,
                    onTap: () =>
                        controller.onVehicleMenuTap(AppStrings.tracking),
                  ),
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuPlayback,
                    title: AppStrings.playback,
                    onTap: () =>
                        controller.onVehicleMenuTap(AppStrings.playback),
                  ),
                ],
              ),
              20.h.sizeBoxFromHeight(),
              _menuSection(
                children: [
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuDetail,
                    title: AppStrings.detail,
                    onTap: () => controller.onVehicleMenuTap(AppStrings.detail),
                  ),
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuCommand,
                    title: AppStrings.command,
                    onTap: () =>
                        controller.onVehicleMenuTap(AppStrings.command),
                  ),
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuAlert,
                    title: AppStrings.alert,
                    onTap: () => controller.onVehicleMenuTap(AppStrings.alert),
                  ),
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuManagement,
                    title: AppStrings.vehicleManagement,
                    onTap: () => controller
                        .onVehicleMenuTap(AppStrings.vehicleManagement),
                  ),
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuShare,
                    title: AppStrings.shareLocation,
                    onTap: () =>
                        controller.onVehicleMenuTap(AppStrings.shareLocation),
                  ),
                ],
              ),
              20.h.sizeBoxFromHeight(),
              _menuSection(
                children: [
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuOverspeed,
                    title: AppStrings.overSpeed,
                    onTap: () =>
                        controller.onVehicleMenuTap(AppStrings.overSpeed),
                  ),
                  VehicleMenuTile(
                    icon: Assets.vehicleMenuReports,
                    title: AppStrings.reports,
                    onTap: () =>
                        controller.onVehicleMenuTap(AppStrings.reports),
                  ),
                ],
              ),
              16.h.sizeBoxFromHeight(),
            ],
          ),
        ),
      );
    });
  }

  Widget _menuSection({required List<Widget> children}) {
    return Container(
      color: AppColors.whiteColor,
      child: Column(children: children),
    );
  }
}
