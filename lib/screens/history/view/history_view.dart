import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/history/viewModel/history_view_model.dart';
import 'package:gps_software/screens/history/widgets/history_playback_panel.dart';
import 'package:gps_software/util/app_constant.dart';

class HistoryView extends GetView<HistoryViewModel> {
  static const historyView = '/historyView';

  static const LatLng _initialTarget = LatLng(22.5800, 88.2300);

  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6f9),
      appBar: TrackingAppBar(
        title: controller.title,
        subtitle: Obx(
          () => controller.hasData
              ? CustomWidget.text(
                  'Total Distance : ${controller.totalDistanceKm.value.toStringAsFixed(2)}KM',
                  color: AppColors.whiteColor,
                  fontSize: 13,
                  letterSpacing: 0,
                )
              : const SizedBox.shrink(),
        ),
        actions: [
          IconButton(
            onPressed: controller.openFilterDialog,
            icon: Icon(Icons.calendar_month,
                color: AppColors.whiteColor, size: 30.r),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      parseVehicleLatLng(controller.vehicle, _initialTarget),
                  zoom: 13,
                ),
                onMapCreated: controller.onMapCreated,
                mapType: controller.mapType.value,
                markers: controller.markers.value,
                polylines: controller.polylines.value,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                padding: EdgeInsets.only(bottom: 200.h),
              ),
            ),
          ),

          // Speed & map type buttons
          Positioned(
            top: 12.h,
            right: 12.w,
            child: Column(
              children: [
                Obx(
                  () => MapCircleButton(
                    onTap: controller.changeSpeed,
                    size: 52,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.fast_forward_rounded,
                            color: AppColors.whiteColor, size: 26.r),
                        if (controller.speedIndex.value > 0)
                          CustomWidget.text(
                            '${controller.playbackSpeed}x',
                            color: AppColors.whiteColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                MapCircleButton(
                  onTap: controller.changeMapType,
                  size: 52,
                  child: Image.asset(Assets.mapLayersIcon, width: 28.r),
                ),
              ],
            ),
          ),

          // Bottom panel with zoom controls above it
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w, bottom: 8.h),
                  child: MapZoomControls(
                    controller: () => controller.mapController,
                  ),
                ),
                const HistoryPlaybackPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
