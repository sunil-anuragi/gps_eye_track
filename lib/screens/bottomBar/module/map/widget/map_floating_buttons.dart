import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/map_floating_action_button.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/map/viewModel/map_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class MapFloatingButtons extends GetView<MapViewModel> {
  const MapFloatingButtons({super.key});

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
                onTap: controller.toggleMapType,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(iconAsset: Assets.mapTitleIcon,iconSize: 50 ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(iconAsset: Assets.mapGeofenceIcon,iconSize: 50 ),
              8.h.sizeBoxFromHeight(),  
              MapFloatingActionButton(iconAsset: Assets.mapLocationIcon,iconSize: 50 ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(iconAsset: Assets.mapTerminalIcon,iconSize: 50 ),
              8.h.sizeBoxFromHeight(),  
              MapFloatingActionButton(iconAsset: Assets.mapRouteIcon,iconSize: 50 ),
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
                onTap: controller.goToDefaultLocation,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapZoomInIcon,
                onTap: controller.zoomIn,
                iconSize: 50,
              ),
              8.h.sizeBoxFromHeight(),
              MapFloatingActionButton(
                iconAsset: Assets.mapZoomOutIcon,
                onTap: controller.zoomOut,
                iconSize: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
