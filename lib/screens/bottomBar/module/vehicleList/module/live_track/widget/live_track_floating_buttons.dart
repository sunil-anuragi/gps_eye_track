import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/map_floating_action_button.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class LiveTrackFloatingButtons extends GetView<VehicleListViewModel> {
  const LiveTrackFloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 12.w,
          top: 60.h,
          child: Column(
            children: [
              MapFloatingActionButton(iconAsset: Assets.mapTrafficIcon,iconSize: 50),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapLayersIcon,
                onTap: controller.toggleLiveTrackMapType,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(iconAsset: Assets.mapGeofenceIcon,iconSize: 50),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapLocationIcon,
                onTap: controller.showImmobilizeDialog,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(iconAsset: Assets.mapTerminalIcon,iconSize: 50),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapRouteIcon,
                onTap: controller.showGeofenceConfirmDialog,
                iconSize: 50,
              ),
            ],
          ),
        ),
        Positioned(
          left: 12.w,
          bottom: 80.h,
          child: Column(
            children: [
              MapFloatingActionButton(
                iconAsset: Assets.mapMyLocationIcon,
                onTap: controller.goToLiveTrackVehicle,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapZoomInIcon,
                onTap: controller.liveTrackZoomIn,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapZoomOutIcon,
                onTap: controller.liveTrackZoomOut,
                iconSize: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
