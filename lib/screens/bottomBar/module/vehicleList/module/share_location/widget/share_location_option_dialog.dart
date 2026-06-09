import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ShareLocationOptionDialog extends GetView<VehicleListViewModel> {
  const ShareLocationOptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.text(
              AppStrings.shareLocation,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
            20.h.sizeBoxFromHeight(),
            _optionButton(
              label: AppStrings.shareLocationDuration,
              onTap: controller.onShareLocationDuration,
            ),
            12.h.sizeBoxFromHeight(),
            _optionButton(
              label: AppStrings.shareLocationCurrent,
              onTap: controller.onShareLocationCurrent,
            ),
            12.h.sizeBoxFromHeight(),
           CustomWidget.customButton(
             callBack: (){},
             btnText: AppStrings.cancel,
             borderRadius: 24.0,
             textSize: 14,
             fontWeight: FontWeight.w700,
             color: AppColors.primaryColor,
             width: double.infinity,
             height: 48,
           ),
          ],
        ),
      ),
    );
  }

  Widget _optionButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return BouncingWidget(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: CustomWidget.text(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
