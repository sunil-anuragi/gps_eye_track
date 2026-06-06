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
                width: isSelected ? 3.5 : 3,
              ),
              borderRadius: BorderRadius.circular(3.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withValues(alpha: 0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: CustomWidget.text(
                '${item.count}',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: item.borderColor,
              ),
            ),
          ),
          8.h.sizeBoxFromHeight(),
          CustomWidget.text(
            item.label,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w700,
            color: isSelected ? item.borderColor : AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
