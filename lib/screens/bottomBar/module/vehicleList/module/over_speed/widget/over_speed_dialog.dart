import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class OverSpeedDialog extends GetView<VehicleListViewModel> {
  const OverSpeedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.text(
              AppStrings.overSpeed,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
            20.h.sizeBoxFromHeight(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.searchBgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextField(
                controller: controller.overSpeedController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: AppColors.blackColor,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ),
            28.h.sizeBoxFromHeight(),
            Row(
              children: [
                Expanded(
                  child: CustomWidget.customButton(
                    callBack: controller.onOverSpeedCancel,
                    btnText: AppStrings.cancel,
                    borderRadius: 10.0,
                    color: AppColors.primaryColor,
                    height: 44,
                    fontWeight: FontWeight.w600,
                    textSize: 14.0,
                    width: double.infinity,
                  ),
                ),
                16.w.sizeBoxFromWidth(),
                Expanded(
                  child: CustomWidget.customButton(
                    callBack: controller.onOverSpeedSubmit,
                    btnText: AppStrings.submit,
                    borderRadius: 10.0,
                    color: AppColors.primaryColor,
                    height: 44,
                    fontWeight: FontWeight.w600,
                    textSize: 14.0,
                    width: double.infinity,
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
