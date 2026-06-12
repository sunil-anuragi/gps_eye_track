import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_circular_button.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceMapControls extends GetView<AccountViewModel> {
  const GeofenceMapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 12.w,
          top: 16.h,
          child: Column(
            children: [
              GeofenceCircularButton(
                iconAsset: Assets.geofenceMyLocationIcon,
                color: AppColors.geofenceBlueColor,
                onTap: controller.goToGeofenceCenter,
              ),
              10.h.sizeBoxFromHeight(),
              GeofenceCircularButton(
                iconAsset: Assets.geofencePolygonIcon,
                onTap: controller.onGeofencePolygonMode,
              ),
              10.h.sizeBoxFromHeight(),
              GeofenceCircularButton(
                iconAsset: Assets.geofenceClearIcon,
                onTap: controller.onClearGeofence,
              ),
            ],
          ),
        ),
        Positioned(
          right: 12.w,
          top: 16.h,
          child: GeofenceCircularButton(
            iconAsset: Assets.geofenceSaveIcon,
            size: 52,
            iconSize: 25,
            onTap: controller.onGeofenceSaveTap,
          ),
        ),
        Positioned(
          right: 12.w,
          bottom: 120.h,
          child: Column(
            children: [
              _zoomButton(Icons.add, controller.geofenceZoomIn),
              Container(
                width: 36.w,
                height: 1,
                color: AppColors.dividerColor,
              ),
              _zoomButton(Icons.remove, controller.geofenceZoomOut),
            ],
          ),
        ),
      ],
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: AppColors.whiteColor,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 36.w,
          height: 36.h,
          child: Icon(icon, size: 18.r, color: AppColors.blackColor),
        ),
      ),
    );
  }
}
