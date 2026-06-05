import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceCreateDialog extends GetView<AccountViewModel> {
  const GeofenceCreateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: CustomWidget.text(
              AppStrings.createGeofence,
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller.geofenceNameController,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    color: AppColors.blackColor,
                  ),
                  decoration: InputDecoration(
                    hintText: AppStrings.enterName.tr,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: AppColors.grayColor,
                    ),
                    filled: true,
                    fillColor: AppColors.searchBgColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                20.h.sizeBoxFromHeight(),
                Row(
                  children: [
                    Expanded(
                      child: CustomWidget.customButton(
                        callBack: controller.onGeofenceCancelDialog,
                        btnText: AppStrings.cancel,
                         borderRadius: 32.0,
                        color: AppColors.primaryColor,
                        height: 44,
                      ),
                    ),
                    12.w.sizeBoxFromWidth(),
                    Expanded(
                      child: CustomWidget.customButton(
                        callBack: controller.onSaveGeofence,
                        btnText: AppStrings.save,
                        borderRadius: 32.0,
                        color: AppColors.primaryColor,
                        height: 44,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
