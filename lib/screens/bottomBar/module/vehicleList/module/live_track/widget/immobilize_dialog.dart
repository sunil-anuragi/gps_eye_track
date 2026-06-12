import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ImmobilizeDialog extends GetView<VehicleListViewModel> {
  const ImmobilizeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleId =
        controller.selectedVehicle.value?.vehicleId ?? AppStrings.sampleVehicleName;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              color: AppColors.dividerColor,
              child: CustomWidget.text(
                vehicleId,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              color: AppColors.whiteColor,
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.immobilizeCarIcon,
                        width: 40.r,
                        height: 40.r,
                        fit: BoxFit.contain,
                      ),
                      12.w.sizeBoxFromWidth(),
                      Expanded(
                        child: CustomWidget.text(
                          AppStrings.immobilizeMessage,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                          maxLine: 3,
                        ),
                      ),
                    ],
                  ),
                  16.h.sizeBoxFromHeight(),
                  TextField(
                    controller: controller.immobilizePasswordController,
                    obscureText: true,
                    style: TextStyle(
                      fontFamily: 'Dmsans',
                      fontSize: 13.sp,
                      color: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      hintText: AppStrings.requiredLoginPassword,
                      hintStyle: TextStyle(
                        fontFamily: 'Dmsans',
                        fontSize: 12.sp,
                        color: AppColors.iconGrayColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.r),
                        borderSide: const BorderSide(
                          color: AppColors.blackColor,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.r),
                        borderSide: const BorderSide(
                          color: AppColors.blackColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.r),
                        borderSide: const BorderSide(
                          color: AppColors.blackColor,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: controller.onImmobilizeCancel,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        color: AppColors.dividerColor,
                        alignment: Alignment.center,
                        child: CustomWidget.text(
                          AppStrings.cancel,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: controller.onFuelSupplyCutOff,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        color: AppColors.redlightColor,
                        alignment: Alignment.center,
                        child: CustomWidget.text(
                          AppStrings.fuelSupplyCutOff,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                          textAlign: TextAlign.center,
                          maxLine: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
