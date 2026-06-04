import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/viewModel/bottom_bar_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class CustomDrawerWidget extends GetView<BottomBarViewModel> {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget trailing = CustomWidget.customAssetImageWidget(
        image: Assets.assetsArrowRight,
        height: 15.r,
        width: 15.r,
        color: AppColors.darkBlack);

    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SizedBox(
        height: 1.sh,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            MediaQuery.of(context).padding.top.verticalSpace,
            Container(
              child: CustomWidget.customAssetImageWidget(
                  image: Assets.assetsAppLogo, height: 140.h, width: 70.w),
            ),
            drawerListTile(
                title: "Profile",
                leading: Assets.assetsProfile,
                trailing: trailing,
                callBack: () {
                  Get.back();
                }),
            drawerListTile(
                title: "Support",
                leading: Assets.assetsSupport,
                trailing: trailing,
                callBack: () {
                  Get.back();
                }),
            drawerListTile(
                title: "About Us",
                leading: Assets.assetsAboutUs,
                trailing: trailing,
                callBack: () {
                  Get.back();
                }),
            drawerListTile(
                title: "Log Out",
                leading: Assets.assetsLogout,
                callBack: () {
                  Get.back();
                }),
            30.h.verticalSpace,
            Obx(() {
              return Center(
                  child: CustomWidget.text(
                      "App Version - V${controller.appVersion.value}",
                      color: AppColors.gray.shade900,
                      fontSize: 12));
            }),
          ],
        ),
      ),
    );
  }

  Widget drawerListTile({
    required String title,
    required String leading,
    bool isFromVehicle = false,
    bool isFromService = false,
    Widget? trailing,
    required Function callBack,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: isFromService ? 12.w : 0,
        right: 8.w,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => callBack(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomWidget.customAssetImageWidget(
                    image: leading,
                    width: 26.r,
                    height: 26.r,
                  ),
                  10.w.sizeBoxFromWidth(),
                  Expanded(
                    child: CustomWidget.text(
                      title.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: title == "Log Out"
                          ? AppColors.logoutRedColor
                          : AppColors.blackColor,
                    ),
                  ),
                  if (trailing != null) trailing
                ],
              ),
            ),
          ),
          Container(
            height: 0.5.h,
            color: AppColors.gray.shade500,
          ),
        ],
      ),
    );
  }
}
