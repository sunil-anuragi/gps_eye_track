import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/map/viewModel/map_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class MapRefreshOverlay extends GetView<MapViewModel> {
  const MapRefreshOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.h,
      left: 12.w,
      child: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.mapOverlayColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: CustomWidget.text(
            '${AppStrings.refreshIn} : ${controller.refreshSeconds.value} ${AppStrings.sec}',
            color: AppColors.whiteColor,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        );
      }),
    );
  }
}
