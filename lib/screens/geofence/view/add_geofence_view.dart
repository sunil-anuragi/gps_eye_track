import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/geofence/model/geofence.dart';
import 'package:gps_software/screens/geofence/viewModel/add_geofence_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Map to draw a circle or polygon geofence. Pops with the saved [Geofence].
class AddGeofenceView extends GetView<AddGeofenceViewModel> {
  static const addGeofenceView = '/addGeofenceView';

  const AddGeofenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrackingAppBar(
        title: controller.editing == null ? 'Add Geofence' : 'Edit Geofence',
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    initialCameraPosition: controller.initialCamera,
                    onMapCreated: controller.onMapCreated,
                    onCameraMove: controller.onCameraMove,
                    onTap: controller.onMapTap,
                    markers: controller.markers,
                    circles: controller.circles,
                    polygons: controller.polygons,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                  ),
                ),

                // Drawing tools
                Positioned(
                  top: 10.h,
                  left: 8.w,
                  child: Obx(
                    () => Column(
                      children: [
                        _ToolButton(
                          icon: Icons.circle_outlined,
                          isActive:
                              controller.shape.value == GeofenceShape.circle,
                          onTap: () =>
                              controller.selectShape(GeofenceShape.circle),
                        ),
                        SizedBox(height: 10.h),
                        _ToolButton(
                          icon: Icons.format_shapes_outlined,
                          isActive:
                              controller.shape.value == GeofenceShape.polygon,
                          onTap: () =>
                              controller.selectShape(GeofenceShape.polygon),
                        ),
                        SizedBox(height: 10.h),
                        _ToolButton(
                          icon: Icons.highlight_off,
                          onTap: controller.clear,
                        ),
                      ],
                    ),
                  ),
                ),

                // Save
                Positioned(
                  top: 10.h,
                  right: 8.w,
                  child: _ToolButton(
                    icon: Icons.save_outlined,
                    onTap: controller.save,
                  ),
                ),

                // Zoom
                Positioned(
                  right: 8.w,
                  bottom: 12.h,
                  child: Column(
                    children: [
                      _ToolButton(
                        icon: Icons.add,
                        onTap: () => controller.zoom(true),
                      ),
                      SizedBox(height: 10.h),
                      _ToolButton(
                        icon: Icons.remove,
                        onTap: () => controller.zoom(false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _BottomPanel(controller: controller),
        ],
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({required this.controller});

  final AddGeofenceViewModel controller;

  static const Color _teal = Color(0xff2ad4c0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.fromLTRB(
        6.w,
        12.h,
        6.w,
        MediaQuery.of(context).padding.bottom + 6.h,
      ),
      child: Obx(() {
        if (controller.shape.value == GeofenceShape.polygon) {
          final count = controller.points.length;
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CustomWidget.text(
              count == 0
                  ? 'Tap on the map to add polygon points'
                  : 'Polygon Points : $count${count < 3 ? '  (min 3)' : ''}',
              fontSize: 14,
              letterSpacing: 0,
              textAlign: TextAlign.center,
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.text(
              'Circular Radius : ${controller.radius.value.toStringAsFixed(1)} Mtr',
              fontSize: 14,
              letterSpacing: 0,
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _teal,
                inactiveTrackColor: const Color(0xffd6d6d6),
                thumbColor: _teal,
                overlayColor: _teal.withValues(alpha: 0.15),
                trackHeight: 2,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              ),
              child: Slider(
                value: controller.radius.value,
                min: AddGeofenceViewModel.minRadius,
                max: AddGeofenceViewModel.maxRadius,
                onChanged: controller.onRadiusChanged,
              ),
            ),
          ],
        );
      }),
    );
  }
}

/// Round brand-blue map button; darker when [isActive]
class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = 44.r;
    return Material(
      color: isActive ? TrackingColors.darkNavy : TrackingColors.brandBlue,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: AppColors.whiteColor, size: size * 0.55),
        ),
      ),
    );
  }
}
