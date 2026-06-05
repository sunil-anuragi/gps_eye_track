import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? AppColors.activeTabColor : AppColors.iconGrayColor;

    return BouncingWidget(
      onTap: onTap,
      scaleFactor: 0.92,
      duration: const Duration(milliseconds: 120),
      child: SizedBox(
        width: 75.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isSelected ? 6.r : 4.r),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.activeTabColor.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CustomWidget.customAssetImageWidget(
                  image: icon,
                  height: 24.r,
                  width: 24.r,
                  color: color,
                ),
              ),
            ),
            // AnimatedSize(
            //   duration: const Duration(milliseconds: 250),
            //   curve: Curves.easeInOut,
            //   child: isSelected
            //       ? Padding(
            //           padding: EdgeInsets.only(top: 4.h),
            //           child: AnimatedOpacity(
            //             opacity: isSelected ? 1.0 : 0.0,
            //             duration: const Duration(milliseconds: 200),
            //             child: CustomWidget.text(
            //               label,
            //               fontSize: 11,
            //               fontWeight: FontWeight.w600,
            //               color: AppColors.activeTabColor,
            //             ),
            //           ),
            //         )
            //       : SizedBox(height: 0, width: 72.w),
            // ),
          ],
        ),
      ),
    );
  }
}
