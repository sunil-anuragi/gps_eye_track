import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/geofence/model/geofence.dart';
import 'package:gps_software/screens/geofence/viewModel/geofence_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Saved geofences. The pencil adds one, tapping a row edits it and a long
/// press deletes it.
class GeofenceView extends GetView<GeofenceViewModel> {
  static const geofenceView = '/geofenceView';

  const GeofenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: TrackingAppBar(
        title: 'Geofence',
        actions: [
          IconButton(
            onPressed: controller.openEditor,
            icon: Icon(Icons.edit, color: AppColors.whiteColor, size: 22.r),
          ),
          SizedBox(width: 6.w),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: TrackingColors.brandBlue),
          );
        }
        if (controller.geofences.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fence, size: 56.r, color: Colors.grey.shade400),
                SizedBox(height: 10.h),
                CustomWidget.text(
                  'No geofence yet.\nTap ✎ to draw one on the map.',
                  color: const Color(0xff7a7a7a),
                  fontSize: 13,
                  letterSpacing: 0,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          itemCount: controller.geofences.length,
          separatorBuilder: (_, __) => SizedBox(height: 14.h),
          itemBuilder: (_, index) {
            final geofence = controller.geofences[index];
            return _GeofenceRow(
              geofence: geofence,
              onTap: () => controller.openEditor(geofence),
              onLongPress: () => _confirmDelete(geofence),
            );
          },
        );
      }),
    );
  }

  void _confirmDelete(Geofence geofence) {
    Get.dialog(
      BadgeDialog(
        title: 'Delete Geofence',
        children: [
          badgeDialogSubtitle('Delete "${geofence.name}"?'),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: badgeDialogButton('Cancel', Get.back)),
              SizedBox(width: 12.w),
              Expanded(
                child: badgeDialogButton('Delete', () {
                  Get.back();
                  controller.deleteGeofence(geofence);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GeofenceRow extends StatelessWidget {
  const _GeofenceRow({
    required this.geofence,
    required this.onTap,
    required this.onLongPress,
  });

  final Geofence geofence;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        onLongPress: onLongPress,
        child: SizedBox(
          height: 46.h,
          child: Row(
            children: [
              SizedBox(width: 18.w),
              Expanded(
                child: CustomWidget.text(
                  geofence.name,
                  fontSize: 13.5,
                  letterSpacing: 0.3,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GeofenceShapeIcon(shape: geofence.shape, size: 26.r),
              SizedBox(width: 16.w),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grey square with a white circle or polygon outline
class GeofenceShapeIcon extends StatelessWidget {
  const GeofenceShapeIcon({
    super.key,
    required this.shape,
    required this.size,
    this.color = const Color(0xff8a8a8a),
  });

  final GeofenceShape shape;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.14),
      ),
      alignment: Alignment.center,
      child: shape == GeofenceShape.circle
          ? Container(
              width: size * 0.7,
              height: size * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.whiteColor, width: 1.2),
              ),
            )
          : Icon(Icons.pentagon_outlined,
              color: AppColors.whiteColor, size: size * 0.78),
    );
  }
}
