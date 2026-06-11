import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackMapControls extends GetView<VehicleListViewModel> {
  const PlaybackMapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 12.h,
          right: 10.w,
          child: _mapButton(
            Icons.layers_outlined,
            onTap: controller.togglePlaybackMapType,
          ),
        ),
        Positioned(
          right: 10.w,
          bottom: 56.h,
          child: Column(
            children: [
              _mapButton(Icons.add, onTap: controller.playbackZoomIn),
              6.h.sizeBoxFromHeight(),
              _mapButton(Icons.remove, onTap: controller.playbackZoomOut),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mapButton(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(4.r),
        child: Icon(icon, color: AppColors.whiteColor, size: 28.r),
      ),
    );
  }
}
