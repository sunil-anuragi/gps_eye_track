import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class FuelCutoffSuccessDialog extends GetView<VehicleListViewModel> {
  const FuelCutoffSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 30.h),
            padding: EdgeInsets.fromLTRB(24.w, 44.h, 24.w, 24.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                15.h.sizeBoxFromHeight(),
                CustomWidget.text(
                  AppStrings.fuelCutOffSuccessfully,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                  textAlign: TextAlign.center,
                ),
                28.h.sizeBoxFromHeight(),
                CustomWidget.customButton(
                  callBack: controller.onFuelCutoffContinue,
                  btnText: AppStrings.continueText,
                  borderRadius: 28.0,
                  color: AppColors.primaryColor,
                  height: 48,
                  fontWeight: FontWeight.w400,
                  textSize: 12.0,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
           
            child: Container(
              width: 70.r,
              height: 70.r,
              decoration: BoxDecoration(
                color: AppColors.fuelCutoffIconBgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(8.r),
              child: Image.asset(
                Assets.fuelCutoffSuccessIcon,
                fit: BoxFit.contain,
                height: 60.r,
                width: 60.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
