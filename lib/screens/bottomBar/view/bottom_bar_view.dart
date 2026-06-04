import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/viewModel/bottom_bar_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class BottomBarView extends GetView<BottomBarViewModel> {
  static const bottomBarView = "/bottomBarView";
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.buildMainScreen()[controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 8,
              offset: Offset(0, -2),
              spreadRadius: 0,
            )
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
            child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      activeIcon: Container(
                        width: 64.w,
                        height: 32.h,
                        decoration: CustomWidget.customBoxDecoration(
                            color: AppColors.primaryColor, borderRadius: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomWidget.customAssetImageWidget(
                              image: Assets.assetsActiveVehicle,
                              height: 18.r,
                              width: 18.r,
                              color: AppColors.whiteColor),
                        ),
                      ),
                      icon: CustomWidget.customAssetImageWidget(
                        image: Assets.assetsVehicle,
                        height: 18.r,
                        color: AppColors.gray.shade700,
                        width: 18.r,
                      ),
                      label: 'Vehicle'.tr),
                  BottomNavigationBarItem(
                      activeIcon: Container(
                        width: 64.w,
                        height: 32.h,
                        decoration: CustomWidget.customBoxDecoration(
                            color: AppColors.primaryColor, borderRadius: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomWidget.customAssetImageWidget(
                              image: Assets.assetsActiveMap,
                              height: 18.r,
                              width: 18.r,
                              color: AppColors.whiteColor),
                        ),
                      ),
                      icon: CustomWidget.customAssetImageWidget(
                        image: Assets.assetsMap,
                        height: 18.r,
                        color: AppColors.gray.shade700,
                        width: 18.r,
                      ),
                      label: 'Map'.tr),
                  BottomNavigationBarItem(
                      activeIcon: Container(
                        width: 64.w,
                        height: 32.h,
                        decoration: CustomWidget.customBoxDecoration(
                            color: AppColors.primaryColor, borderRadius: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomWidget.customAssetImageWidget(
                              image: Assets.assetsActiveChart,
                              height: 18.r,
                              width: 18.r,
                              color: AppColors.whiteColor),
                        ),
                      ),
                      icon: CustomWidget.customAssetImageWidget(
                        color: AppColors.gray.shade700,
                        image: Assets.assetsChart,
                        height: 18.r,
                        width: 18.r,
                      ),
                      label: 'Chart'.tr),
                  BottomNavigationBarItem(
                      activeIcon: Container(
                        width: 64.w,
                        height: 32.h,
                        decoration: CustomWidget.customBoxDecoration(
                            color: AppColors.primaryColor, borderRadius: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomWidget.customAssetImageWidget(
                              image: Assets.assetsSummary,
                              height: 18.r,
                              width: 18.r,
                              color: AppColors.whiteColor),
                        ),
                      ),
                      icon: CustomWidget.customAssetImageWidget(
                        color: AppColors.gray.shade700,
                        image: Assets.assetsSummary,
                        height: 18.r,
                        width: 18.r,
                      ),
                      label: 'Summary'.tr),
                  BottomNavigationBarItem(
                    activeIcon: Container(
                      width: 64.w,
                      height: 32.h,
                      decoration: CustomWidget.customBoxDecoration(
                          color: AppColors.primaryColor, borderRadius: 16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: CustomWidget.customAssetImageWidget(
                          image: Assets.assetsActiveSetting,
                          color: Colors.white,
                          height: 18.r,
                          width: 18.r,
                        ),
                      ),
                    ),
                    icon: CustomWidget.customAssetImageWidget(
                      image: Assets.assetsSetting,
                      height: 18.r,
                      width: 18.r,
                      color: AppColors.gray.shade700,
                    ),
                    label: 'Setting'.tr,
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: AppColors.primaryColor,
                onTap: (index) {
                  controller.selectedIndex.value = index;
                },
                unselectedLabelStyle: TextStyle(
                    color: AppColors.gray.shade700,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    fontFamily: 'Roboto'),
                selectedLabelStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    fontFamily: 'Roboto'),
                elevation: 5),
          ),
        );
      }),
    );
  }
}
