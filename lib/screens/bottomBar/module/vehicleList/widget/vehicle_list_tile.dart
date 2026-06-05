import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleListTile extends StatelessWidget {
  const VehicleListTile({
    super.key,
    required this.vehicle,
  });

  final VehicleListItem vehicle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
                4.h.sizeBoxFromHeight(),
                CustomWidget.text(
                  vehicle.status,
                  fontSize: 11,
                  color: AppColors.subtitleColor,
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
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isOn ? AppColors.textGreenColor : AppColors.textRedColor,
        ),
        2.h.sizeBoxFromHeight(),
        CustomWidget.text(
          label,
          fontSize: 10,
          color: AppColors.grayColor,
        ),
      ],
    );
  }
}
