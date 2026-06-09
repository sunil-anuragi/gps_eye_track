import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/account_module_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_detail/widget/vehicle_detail_row.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleDetailView extends GetView<VehicleListViewModel> {
  static const vehicleDetailView = '/vehicleDetailView';

  const VehicleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      if (vehicle == null) {
        return const Scaffold(body: SizedBox.shrink());
      }

      final detail = controller.vehicleDetail;

      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AccountModuleAppBar(
          title: vehicle.vehicleId,
          action: TextButton(
            onPressed: controller.onVehicleDetailEdit,
            child: CustomWidget.text(
              AppStrings.edit,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              VehicleDetailRow(
                label: AppStrings.name,
                value: detail.name,
              ),
              VehicleDetailRow(
                label: AppStrings.icon,
                trailing: Image.asset(
                  Assets.vehicleDetailCarIcon,
                  width: 40.r,
                  height: 40.r,
                  fit: BoxFit.fill,
                ),
              ),
              VehicleDetailRow(
                label: AppStrings.imei,
                value: detail.imei,
              ),
              VehicleDetailRow(
                label: AppStrings.simCard,
                value: detail.simCard,
              ),
              VehicleDetailRow(
                label: AppStrings.model,
                value: detail.model,
              ),
              VehicleDetailRow(
                label: AppStrings.activationTime,
                value: detail.activationTime,
              ),
              VehicleDetailRow(
                label: AppStrings.expireDate,
                value: detail.expireDate,
              ),
              VehicleDetailRow(
                label: AppStrings.status,
                value: detail.status,
              ),
              VehicleDetailRow(
                label: AppStrings.gpsTime,
                value: detail.gpsTime,
              ),
              VehicleDetailRow(
                label: AppStrings.latestUpdate,
                value: detail.latestUpdate,
              ),
              VehicleDetailRow(
                label: AppStrings.speed,
                value: detail.speed,
              ),
              VehicleDetailRow(
                label: AppStrings.coordinate,
                value: detail.coordinate,
              ),
              VehicleDetailRow(
                label: AppStrings.engineStatus,
                value: detail.engineStatus,
              ),
            ],
          ),
        ),
      );
    });
  }
}
