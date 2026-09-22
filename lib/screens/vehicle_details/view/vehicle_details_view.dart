import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/vehicle_details/viewModel/vehicle_details_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleDetailsView extends GetView<VehicleDetailsViewModel> {
  static const vehicleDetailsView = '/vehicleDetailsView';

  static const Color _valueColor = Color(0xff9a9a9a);
  static const Color _iconColor = Color(0xff17c1f0);

  const VehicleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: TrackingAppBar(
        title: controller.vehicleNo,
        actions: [
          IconButton(
            onPressed: controller.openIconPicker,
            icon: Icon(Icons.edit, color: AppColors.whiteColor, size: 22.r),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        children: [
          _row('Name', _valueText(controller.vehicleNo)),
          InkWell(
            onTap: controller.openIconPicker,
            child: _row(
              'Icon',
              Obx(
                () => Icon(
                  controller.selectedIcon.value.icon,
                  color: _iconColor,
                  size: 32.r,
                ),
              ),
            ),
          ),
          for (final entry in controller.detailRows)
            _row(entry.key, _valueText(entry.value)),
        ],
      ),
    );
  }

  Widget _row(String label, Widget value) {
    return Container(
      constraints: BoxConstraints(minHeight: 46.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: TrackingColors.divider)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: CustomWidget.text(
              label,
              fontSize: 14,
              letterSpacing: 0,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: value),
          ),
        ],
      ),
    );
  }

  Widget _valueText(String value) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: CustomWidget.text(
        value,
        color: _valueColor,
        fontSize: 14,
        letterSpacing: 0,
        maxLine: 1,
      ),
    );
  }
}
