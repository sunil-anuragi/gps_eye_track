import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/viewModel/bottom_bar_view_model.dart';
import 'package:gps_software/screens/bottomBar/widget/bottom_nav_item.dart';
import 'package:gps_software/util/app_constant.dart';

class CustomBottomNavBar extends GetView<BottomBarViewModel> {
  const CustomBottomNavBar({super.key});

  static const _navItems = [
    (icon: Assets.assetsNavMap, label: AppStrings.map),
    (icon: Assets.assetsNavList, label: AppStrings.list),
    (icon: Assets.assetsNavNotification, label: AppStrings.notification),
    (icon: Assets.assetsNavAccount, label: AppStrings.account),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedIndex = controller.selectedIndex.value;
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navItems.length,
                (index) => BottomNavItem(
                  icon: _navItems[index].icon,
                  label: _navItems[index].label,
                  isSelected: selectedIndex == index,
                  onTap: () => controller.onTabSelected(index),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
