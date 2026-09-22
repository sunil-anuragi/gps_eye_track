import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/history/view/history_view.dart';
import 'package:gps_software/screens/live_tracking/viewModel/live_tracking_view_model.dart';
import 'package:gps_software/screens/live_tracking/widgets/live_vehicle_info_card.dart';
import 'package:gps_software/util/app_constant.dart';

class LiveTrackingView extends GetView<LiveTrackingViewModel> {
  static const liveTrackingView = '/liveTrackingView';

  const LiveTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6f9),
      appBar: TrackingAppBar(title: controller.title),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.vehiclePosition.value,
                      zoom: 17,
                    ),
                    onMapCreated: controller.onMapCreated,
                    mapType: controller.mapType.value,
                    trafficEnabled: controller.isTrafficEnabled.value,
                    markers: controller.markers.value,
                    buildingsEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                  ),
                ),

                // Refresh countdown
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: _buildCountdown(),
                ),

                // Action buttons
                Positioned(
                  top: 10.h,
                  right: 12.w,
                  bottom: 110.h,
                  child: SingleChildScrollView(
                    child: _buildActionButtons(),
                  ),
                ),

                // Zoom controls
                Positioned(
                  right: 12.w,
                  bottom: 12.h,
                  child: MapZoomControls(
                    controller: () => controller.mapController,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => LiveVehicleInfoCard(
              title: controller.title,
              speed: controller.speed.value,
              lastUpdate: controller.lastUpdate.value,
              status: controller.duration.value.isEmpty
                  ? controller.status.value
                  : '${controller.status.value} (${controller.duration.value})',
              isRunning: controller.isRunning,
              address: controller.address.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdown() {
    return Obx(() {
      final progress =
          controller.countdown.value / LiveTrackingViewModel.refreshInterval;
      return SizedBox(
        width: 52.r,
        height: 52.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 48.r,
              height: 48.r,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 2.5,
                color: AppColors.whiteColor,
                backgroundColor: Colors.white24,
              ),
            ),
            CustomWidget.text(
              '${controller.countdown.value}s',
              color: AppColors.whiteColor,
              fontSize: 15,
              letterSpacing: 0,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    final gap = SizedBox(height: 10.h);
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MapCircleButton(
            icon: Icons.traffic,
            isActive: controller.isTrafficEnabled.value,
            onTap: controller.toggleTraffic,
          ),
          gap,
          MapCircleButton(
            onTap: controller.changeMapType,
            child: Image.asset(Assets.mapLayersIcon, width: 26.r),
          ),
          gap,
          MapCircleButton(
            icon: controller.isLocked.value
                ? Icons.lock_outline
                : Icons.lock_open_outlined,
            isActive: !controller.isLocked.value,
            onTap: controller.toggleLock,
          ),
          gap,
          MapCircleButton(
            icon: Icons.share,
            onTap: controller.shareLocation,
          ),
          gap,
          MapCircleButton(
            icon: Icons.history,
            onTap: () => Get.toNamed(
              HistoryView.historyView,
              arguments: controller.vehicle,
            ),
          ),
          gap,
          MapCircleButton(
            icon: Icons.my_location,
            onTap: controller.recenter,
          ),
          gap,
          MapCircleButton(
            onTap: controller.openInGoogleMaps,
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                Icons.directions,
                color: const Color(0xff34a853),
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
