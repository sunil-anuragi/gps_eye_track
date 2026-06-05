import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceRadiusPanel extends GetView<AccountViewModel> {
  const GeofenceRadiusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.text(
              '${AppStrings.circularRadius} : ${controller.geofenceRadius.value.toStringAsFixed(1)} ${AppStrings.mtr}',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
            12.h.sizeBoxFromHeight(),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 2.h,
                activeTrackColor: AppColors.blackColor,
                inactiveTrackColor: AppColors.dividerColor,
                thumbColor: AppColors.blackColor,
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              ),
              child: Slider(
                min: AccountViewModel.geofenceMinRadius,
                max: AccountViewModel.geofenceMaxRadius,
                value: controller.geofenceRadius.value,
                onChanged: controller.onGeofenceRadiusChanged,
              ),
            ),
          ],
        );
      }),
    );
  }
}
