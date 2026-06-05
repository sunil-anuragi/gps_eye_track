import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/map/viewModel/map_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class MapAddressBar extends GetView<MapViewModel> {
  const MapAddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          color: AppColors.mapOverlayColor,
          child: CustomWidget.text(
            controller.selectedAddress.value,
            color: AppColors.whiteColor,
            fontSize: 11,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }),
    );
  }
}
