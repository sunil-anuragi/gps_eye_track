import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/widget/live_track_floating_buttons.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/widget/live_track_map_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/widget/live_track_tooltip.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class LiveTrackView extends GetView<VehicleListViewModel> {
  static const liveTrackView = '/liveTrackView';

  const LiveTrackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      final liveTrackInfo = controller.liveTrackInfo;

      return PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) controller.stopLiveTrackRefresh();
        },
        child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AccountModuleAppBar(
          title: vehicle?.vehicleId ?? AppStrings.sampleVehicleName,
        ),
        body: Stack(
          children: [
            const LiveTrackMapWidget(),
            Positioned(
              top: 12.h,
              left: 12.w,
              child: Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.mapOverlayColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomWidget.text(
                    '${AppStrings.refreshIn} : ${controller.liveTrackRefreshSeconds.value} ${AppStrings.sec}',
                    color: AppColors.whiteColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (liveTrackInfo != null)
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height * 0.28,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: LiveTrackTooltip(info: liveTrackInfo),
                ),
              ),
            const LiveTrackFloatingButtons(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  color: AppColors.mapOverlayColor,
                  child: CustomWidget.text(
                    controller.liveTrackAddress.value,
                    color: AppColors.whiteColor,
                    fontSize: 11,
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      );
    });
  }
}
