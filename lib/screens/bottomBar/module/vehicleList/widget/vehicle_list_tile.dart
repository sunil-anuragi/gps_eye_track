import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleListTile extends GetView<VehicleListViewModel> {
  const VehicleListTile({
    super.key,
    required this.vehicle,
  });

  final VehicleListItem vehicle;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: () => controller.onVehicleTap(vehicle),
      child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.searchBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_outlined,
              color: AppColors.textGreenColor,
              size: 22.r,
            ),
          ),
          12.w.sizeBoxFromWidth(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidget.text(
                  vehicle.name,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                4.h.sizeBoxFromHeight(),
                CustomWidget.text(
                  vehicle.status,
                  fontSize: 12,
                  color: AppColors.textColor,
                ),
              ],
            ),
          ),
          _statusColumn(
            value: vehicle.isPwrOn ? AppStrings.on : AppStrings.off,
            label: AppStrings.pwr,
            isOn: vehicle.isPwrOn,
          ),
          12.w.sizeBoxFromWidth(),
          _statusColumn(
            value: vehicle.isGpsOn ? AppStrings.on : AppStrings.off,
            label: AppStrings.gps,
            isOn: vehicle.isGpsOn,
          ),
          12.w.sizeBoxFromWidth(),
          _statusColumn(
            value: vehicle.isIgnOn ? AppStrings.on : AppStrings.off,
            label: AppStrings.ign,
            isOn: vehicle.isIgnOn,
          ),
        ],
      ),
    ),
    );
  }

  Widget _statusColumn({
    required String value,
    required String label,
    required bool isOn,
  }) {
    return Column(
      children: [
        CustomWidget.text(
          value,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: isOn ? AppColors.textGreenColor : AppColors.textRedColor,
        ),
        2.h.sizeBoxFromHeight(),
        CustomWidget.text(
          label,
          fontSize: 9,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),
      ],
    );
  }
}
