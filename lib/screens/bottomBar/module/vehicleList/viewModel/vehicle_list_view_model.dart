import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/base_controller.dart';

class StatusFilterItem {
  final String label;
  final int count;
  final Color borderColor;
  final Color bgColor;

  const StatusFilterItem({
    required this.label,
    required this.count,
    required this.borderColor,
    required this.bgColor,
  });
}

class VehicleListItem {
  final String name;
  final String status;
  final bool isPwrOn;
  final bool isGpsOn;
  final bool isIgnOn;

  const VehicleListItem({
    required this.name,
    required this.status,
    required this.isPwrOn,
    required this.isGpsOn,
    required this.isIgnOn,
  });
}

class VehicleListViewModel extends BaseController {
  final TextEditingController searchController = TextEditingController();
  RxInt selectedFilterIndex = 0.obs;

  final List<StatusFilterItem> statusFilters = [
    StatusFilterItem(
      label: AppStrings.all,
      count: 30,
      borderColor: AppColors.allColor,
      bgColor: AppColors.allInnerColor,
    ),
    StatusFilterItem(
      label: AppStrings.running,
      count: 30,
      borderColor: AppColors.runningColor,
      bgColor: AppColors.runningInnerColor.withValues(alpha: 0.29),
    ),
    StatusFilterItem(
      label: AppStrings.stop,
      count: 25,
      borderColor: AppColors.stopColor,
      bgColor: AppColors.stopColor.withValues(alpha: 0.12),
    ),
    StatusFilterItem(
      label: AppStrings.idle,
      count: 20,
      borderColor: AppColors.idleColor,
      bgColor: AppColors.idleInnerColor,
    ),
    StatusFilterItem(
      label: AppStrings.offline,
      count: 50,
      borderColor: AppColors.offlineColor,
      bgColor: AppColors.offlineInnerColor,
    ),
  ];

  final List<VehicleListItem> vehicles = const [
    VehicleListItem(
      name: 'ACUTE140',
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE141',
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE142',
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE143',
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE144',
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE145',
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
  ];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
