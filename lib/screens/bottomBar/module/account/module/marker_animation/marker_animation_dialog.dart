import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class MarkerAnimationDialog extends GetView<AccountViewModel> {
  const MarkerAnimationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52.h),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    12.h.sizeBoxFromHeight(),
                    _motionButton(
                      label: AppStrings.slowMotion,
                      isSelected: controller.selectedMotion.value ==
                          AppStrings.slowMotion,
                      onTap: () =>
                          controller.selectMotion(AppStrings.slowMotion),
                    ),
                    16.h.sizeBoxFromHeight(),
                    _motionButton(
                      label: AppStrings.jumpMotion,
                      isSelected: controller.selectedMotion.value ==
                          AppStrings.jumpMotion,
                      onTap: () =>
                          controller.selectMotion(AppStrings.jumpMotion),
                    ),
                    20.h.sizeBoxFromHeight(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomWidget.customButton(
                            callBack: controller.onMarkerAnimationCancel,
                            btnText: AppStrings.cancel,
                            borderRadius: 32.0,
                            color: AppColors.primaryColor,
                            height: 44,
                            fontWeight: FontWeight.w400,
                            textSize: 14.0,
                          ),
                        ),
                        12.w.sizeBoxFromWidth(),
                        Expanded(
                          child: CustomWidget.customButton(
                            callBack: controller.onMarkerAnimationOk,
                            btnText: AppStrings.ok,
                            borderRadius: 32.0,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            textSize: 14.0,
                            height: 44,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(14.r),
                child: CustomWidget.customAssetImageWidget(
                  image: Assets.assetsMarkerAnimationCar,
                  height: 72.r,
                  width: 72.r,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _motionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return CustomWidget.customButton(
      callBack: onTap,
      btnText: label,
      borderRadius: 6.0,
      color: isSelected ? AppColors.primaryColor : AppColors.primaryColor,
      width: double.infinity,
      height: 44,
      fontWeight: FontWeight.w500,
      textSize: 12.0,
    );
  }
}
