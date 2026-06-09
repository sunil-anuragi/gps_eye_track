import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceConfirmDialog extends GetView<VehicleListViewModel> {
  const GeofenceConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleId =
        controller.selectedVehicle.value?.vehicleId ?? AppStrings.sampleVehicleName;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 5.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.geofenceConfirmWarningIcon,
                  width: 30.r,
                  height: 30.r,
                  fit: BoxFit.contain,
                ),
                8.w.sizeBoxFromWidth(),
                CustomWidget.text(
                  AppStrings.confirm,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ],
            ),
            16.h.sizeBoxFromHeight(),
            CustomWidget.text(
              '${AppStrings.geofenceConfirmPrefix}$vehicleId?',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
              maxLine: 4,
            ),
            12.h.sizeBoxFromHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: controller.onGeofenceConfirmNo,
                  child: CustomWidget.text(
                    AppStrings.no,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: controller.onGeofenceConfirmYes,
                  child: CustomWidget.text(
                    AppStrings.yes,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
