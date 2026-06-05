import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/widget/status_filter_card.dart';

class StatusFilterRow extends GetView<VehicleListViewModel> {
  const StatusFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: List.generate(
            controller.statusFilters.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                right: index < controller.statusFilters.length - 1 ? 12.w : 0,
              ),
              child: StatusFilterCard(
                item: controller.statusFilters[index],
                isSelected: controller.selectedFilterIndex.value == index,
                onTap: () => controller.selectedFilterIndex.value = index,
              ),
            ),
          ),
        ),
      );
    });
  }
}
