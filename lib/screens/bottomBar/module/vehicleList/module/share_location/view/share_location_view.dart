import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/share_location/widget/share_location_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ShareLocationView extends GetView<VehicleListViewModel> {
  static const shareLocationView = '/shareLocationView';

  const ShareLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      if (vehicle == null) {
        return const Scaffold(body: SizedBox.shrink());
      }

      return Scaffold(
        backgroundColor: AppColors.screenBgColor,
        appBar: GeofenceAppBar(
          title: vehicle.vehicleId,
          action: IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor, size: 24.r),
            onPressed: controller.onAddShareLocation,
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
          itemCount: controller.shareLocationItems.length,
          itemBuilder: (context, index) {
            final item = controller.shareLocationItems[index];
            return ShareLocationTile(
              item: item,
              onTap: () => controller.onShareLocationItemTap(item),
            );
          },
        ),
      );
    });
  }
}
