import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackSpeedScaleDialog extends GetView<VehicleListViewModel> {
  const PlaybackSpeedScaleDialog({super.key});

  static const _speedOptions = [
    AppStrings.slow,
    AppStrings.normal,
    AppStrings.fastSpeed,
    AppStrings.veryFast,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 80.h),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CustomWidget.text(
                AppStrings.setPlayBackTime,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            12.h.sizeBoxFromHeight(),
            Divider(height: 1, color: AppColors.borderGrayColor),
            Obx(
              () => Column(
                children: _speedOptions.map((option) {
                  final isSelected =
                      controller.playbackSelectedSpeed.value == option;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => controller.onPlaybackSpeedChanged(option),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 4.h,
                          ),
                          child: Row(
                            children: [
                              Radio<String>(
                                value: option,
                                groupValue:
                                    controller.playbackSelectedSpeed.value,
                                activeColor: AppColors.playbackSpeedActiveColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.onPlaybackSpeedChanged(value);
                                  }
                                },
                              ),
                              CustomWidget.text(
                                option,
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: AppColors.playbackInfoValueColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 1, color: AppColors.borderGrayColor),
                    ],
                  );
                }).toList(),
              ),
            ),
            12.h.sizeBoxFromHeight(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomWidget.customButton(
                      callBack: () => Get.back(),
                      btnText: AppStrings.cancel,
                      borderRadius: 8.0,
                      color: AppColors.primaryColor,
                      height: 44,
                      fontWeight: FontWeight.w600,
                      textSize: 14.0,
                      width: double.infinity,
                    ),
                  ),
                  10.w.sizeBoxFromWidth(),
                  Expanded(
                    child: CustomWidget.customButton(
                      callBack: () => Get.back(),
                      btnText: AppStrings.ok,
                      borderRadius: 8.0,
                      color: AppColors.primaryColor,
                      height: 44,
                      fontWeight: FontWeight.w600,
                      textSize: 14.0,
                      width: double.infinity,
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
