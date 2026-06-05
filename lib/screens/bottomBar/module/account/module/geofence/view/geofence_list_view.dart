import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_device_tile.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceListView extends GetView<AccountViewModel> {
  static const geofenceListView = '/geofenceListView';

  const GeofenceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      appBar: GeofenceAppBar(
        title: controller.geofenceVehicleId,
        action: IconButton(
          icon: Icon(Icons.add, color: AppColors.whiteColor, size: 24.r),
          onPressed: controller.onAddGeofence,
        ),
      ),
      body: 
      // Obx(() {
      //   return 
        
        ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          itemCount: controller.geofenceDevices.length,
          itemBuilder: (context, index) {
            final deviceId = controller.geofenceDevices[index];
            return GeofenceDeviceTile(
              deviceId: deviceId,
              isSelected:
                  controller.selectedGeofenceDevices.contains(deviceId),
              onTap: () => controller.onGeofenceDeviceTap(deviceId),
            );
          },
        )

      // }),
    );
  }
}
