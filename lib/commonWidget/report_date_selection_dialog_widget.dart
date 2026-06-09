import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class ReportDateSelectionDialogWidget extends StatelessWidget {
  const ReportDateSelectionDialogWidget({
    super.key,
    required this.selectedDateRange,
    required this.onSelectDate,
    required this.onClose,
    required this.onOk,
  });

  final String selectedDateRange;
  final ValueChanged<String> onSelectDate;
  final VoidCallback onClose;
  final VoidCallback onOk;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  CustomWidget.text(
                    AppStrings.date,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                  const Spacer(),
                  BouncingWidget(
                    onTap: onClose,
                    child: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                      size: 22.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
              child: Column(
                children: [
                  10.h.sizeBoxFromHeight(),
                  Row(
                    children: [
                      Expanded(
                        child: _dateOption(
                          label: AppStrings.oneHrAgo,
                          isSelected: selectedDateRange == AppStrings.oneHrAgo,
                          onTap: () => onSelectDate(AppStrings.oneHrAgo),
                        ),
                      ),
                      12.w.sizeBoxFromWidth(),
                      Expanded(
                        child: _dateOption(
                          label: AppStrings.today,
                          isSelected: selectedDateRange == AppStrings.today,
                          onTap: () => onSelectDate(AppStrings.today),
                        ),
                      ),
                    ],
                  ),
                  20.h.sizeBoxFromHeight(),
                  Row(
                    children: [
                      Expanded(
                        child: _dateOption(
                          label: AppStrings.yesterday,
                          isSelected:
                              selectedDateRange == AppStrings.yesterday,
                          onTap: () => onSelectDate(AppStrings.yesterday),
                        ),
                      ),
                      12.w.sizeBoxFromWidth(),
                      Expanded(
                        child: _dateOption(
                          label: AppStrings.userDefined,
                          isSelected:
                              selectedDateRange == AppStrings.userDefined,
                          onTap: () => onSelectDate(AppStrings.userDefined),
                        ),
                      ),
                    ],
                  ),
                  25.h.sizeBoxFromHeight(),
                  CustomWidget.customButton(
                    callBack: onOk,
                    btnText: AppStrings.ok,
                    width: double.infinity,
                    height: 44,
                    borderRadius: 8.0,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    textSize: 14.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return BouncingWidget(
      onTap: onTap,
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.supportTealColor
              : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: CustomWidget.text(
          label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
