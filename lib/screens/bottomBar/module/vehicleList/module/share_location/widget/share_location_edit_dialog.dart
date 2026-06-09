import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/animations/bouncing_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ShareLocationEditDialog extends GetView<VehicleListViewModel> {
  const ShareLocationEditDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Obx(() {
        final item = controller.editingShareLocation.value;
        if (item == null) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomWidget.text(
                item.shareId,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
                textAlign: TextAlign.center,
              ),
              20.h.sizeBoxFromHeight(),
              _infoRow(
                label: AppStrings.shareName,
                value: item.shareName,
              ),
              16.h.sizeBoxFromHeight(),
              _infoRow(
                label: AppStrings.validTill,
                value: item.validTill,
                showChevron: true,
                onTap: controller.onShareLocationValidTillTap,
              ),
              20.h.sizeBoxFromHeight(),
              CustomWidget.customButton(
                callBack: () {},
                btnText: AppStrings.save,
                borderRadius: 24.0,
                textSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
                width: double.infinity,
                height: 48,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoRow({
    required String label,
    required String value,
    bool showChevron = false,
    VoidCallback? onTap,
  }) {
    return BouncingWidget(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            CustomWidget.text(
              label,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
            ),
            const Spacer(),
            CustomWidget.text(
              value,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
            ),
            if (showChevron) ...[
              8.w.sizeBoxFromWidth(),
              Image.asset(
                Assets.icArrow,
                width: 8.r,
                height: 13.r,
                color: AppColors.whiteColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
