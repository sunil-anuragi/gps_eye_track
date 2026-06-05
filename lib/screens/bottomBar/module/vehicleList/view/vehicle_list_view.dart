import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/widget/tab_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/widget/status_filter_row.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/widget/vehicle_list_tile.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/widget/vehicle_search_bar.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleListView extends GetView<VehicleListViewModel> {
  const VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: TabAppBar(
        title: AppStrings.appTitle,
        action: IconButton(
          icon: Icon(Icons.refresh, color: AppColors.whiteColor, size: 22.r),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          const StatusFilterRow(),
          const VehicleSearchBar(),
          12.h.sizeBoxFromHeight(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 12.h),
              itemCount: controller.vehicles.length,
              itemBuilder: (context, index) {
                return VehicleListTile(vehicle: controller.vehicles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
