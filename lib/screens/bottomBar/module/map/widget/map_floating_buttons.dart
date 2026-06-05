import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
              _mapButton(Icons.traffic),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.layers, onTap: controller.toggleMapType),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.title),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.grid_on),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.location_on),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.terminal),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.alt_route),
            ],
          ),
        ),
        Positioned(
          left: 12.w,
          bottom: 80.h,
          child: Column(
            children: [
              _mapButton(Icons.my_location, onTap: controller.goToDefaultLocation),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.add, onTap: controller.zoomIn),
              8.h.sizeBoxFromHeight(),
              _mapButton(Icons.remove, onTap: controller.zoomOut),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mapButton(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: AppColors.mapOverlayColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Icon(icon, color: AppColors.whiteColor, size: 18.r),
      ),
    );
  }
}
