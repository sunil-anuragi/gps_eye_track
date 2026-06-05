import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class StatusFilterCard extends StatelessWidget {
  const StatusFilterCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final StatusFilterItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: onTap,
      scaleFactor: 0.92,
      duration: const Duration(milliseconds: 120),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: item.bgColor,
              border: Border.all(
                color: item.borderColor,
                width: isSelected ? 2.5 : 2,
              ),
              borderRadius: BorderRadius.circular(6.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isSelected ? 0.08 : 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: item.borderColor.withValues(alpha: isSelected ? 0.25 : 0.12),
                  blurRadius: isSelected ? 14 : 10,
                  offset: Offset(0, isSelected ? 6 : 4),
                  spreadRadius: isSelected ? 1 : 0,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: CustomWidget.text(
                '${item.count}',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
          ),
          6.h.sizeBoxFromHeight(),
          CustomWidget.text(
            item.label,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? item.borderColor : AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
