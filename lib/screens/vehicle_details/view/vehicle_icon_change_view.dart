import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/vehicle_details/model/vehicle_icon_option.dart';
import 'package:gps_software/screens/vehicle_details/viewModel/vehicle_details_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleIconChangeView extends GetView<VehicleDetailsViewModel> {
  static const vehicleIconChangeView = '/vehicleIconChangeView';

  static const Color _selectedColor = Color(0xff29a9d8);
  static const Color _unselectedColor = Color(0xffa3a3a3);

  const VehicleIconChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: TrackingAppBar(
        title: controller.vehicleNo,
        actions: [
          IconButton(
            onPressed: controller.saveIcon,
            icon: Icon(Icons.save, color: AppColors.whiteColor, size: 24.r),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade400, width: 1.2),
              ),
            ),
            child: Row(
              children: [
                CustomWidget.text('Name', fontSize: 14, letterSpacing: 0),
                const Spacer(),
                CustomWidget.text(
                  controller.vehicleNo,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
                SizedBox(width: 24.w),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 16.h),
              itemCount: VehicleIconOption.all.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 14.h,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (_, index) =>
                  _buildIcon(VehicleIconOption.all[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(VehicleIconOption option) {
    return Obx(() {
      final selected = controller.pendingIcon.value.key == option.key;
      return GestureDetector(
        onTap: () => controller.pendingIcon.value = option,
        child: Tooltip(
          message: option.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: selected
                  ? _selectedColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: selected ? 1.2 : 1,
              child: Icon(
                option.icon,
                color: selected ? _selectedColor : _unselectedColor,
                size: 34.r,
              ),
            ),
          ),
        ),
      );
    });
  }
}
