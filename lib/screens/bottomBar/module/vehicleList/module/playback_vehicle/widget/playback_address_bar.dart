import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackAddressBar extends GetView<VehicleListViewModel> {
  const PlaybackAddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        color: AppColors.mapOverlayColor,
        child: CustomWidget.text(
          controller.playbackAddress.value.isNotEmpty
              ? controller.playbackAddress.value
              : AppStrings.sampleLiveTrackAddress,
          color: AppColors.whiteColor,
          fontSize: 11,
          maxLine: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
