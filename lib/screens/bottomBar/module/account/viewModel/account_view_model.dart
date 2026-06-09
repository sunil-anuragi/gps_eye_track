import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/change_password/view/change_password_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/view/generate_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_date_selection_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/widget/report_selection_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/view/geofence_list_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/view/geofence_map_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_create_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/view/help_support_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/marker_animation/marker_animation_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/delete_account_dialog.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/base_controller.dart';

import '../../../../../generated/assets.dart';

class AccountMenuItem {
  final String icon;
  final String title;

  const AccountMenuItem({
    required this.icon,
    required this.title,
  });
}

enum ReportSelectionDialogType { vehicle, reportType }

class ReportTripItem {
  final String startAddress;
  final String startTime;
  final String endAddress;
  final String endTime;
  final String avgSpeed;
  final String duration;
  final String maxSpeed;
  final String distance;

  const ReportTripItem({
    required this.startAddress,
    required this.startTime,
    required this.endAddress,
    required this.endTime,
    required this.avgSpeed,
    required this.duration,
    required this.maxSpeed,
    required this.distance,
  });
}

class AccountViewModel extends BaseController {
  static const LatLng geofenceCenterLocation = LatLng(28.7024, 77.2695);
  static const double geofenceMinRadius = 100;
  static const double geofenceMaxRadius = 2000;
  static const double geofenceDefaultRadius = 400;

  // Account
  RxString userName = 'SangeetBhati'.obs;
  RxString appVersion = '1.0.0'.obs;

  final List<AccountMenuItem> menuItems = [
    AccountMenuItem(
      icon: Assets.assetsGenrateReport,
      title: AppStrings.generateReports,
    ),
    AccountMenuItem(
      icon: Assets.assetsGeofence,
      title: AppStrings.geofence,
    ),
    AccountMenuItem(
      icon: Assets.assetsGeofence,
      title: AppStrings.markerAnimation,
    ),
    AccountMenuItem(
      icon: Assets.assetsChangePassword,
      title: AppStrings.changePassword,
    ),
    AccountMenuItem(
      icon: Assets.assetsHelpSupport,
      title: AppStrings.helpAndSupport,
    ),
    AccountMenuItem(
      icon: Assets.assetsAccount,
      title: AppStrings.deleteAccount,
    ),
  ];

  // Change password
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool isCurrentPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Geofence list
  final String geofenceVehicleId = 'DL2RQ-3478';
  final List<String> geofenceDevices = List.generate(9, (_) => 'DL23RW8855');
  RxSet<String> selectedGeofenceDevices = <String>{}.obs;

  // Geofence map
  GoogleMapController? geofenceMapController;
  final TextEditingController geofenceNameController = TextEditingController();
  RxDouble geofenceRadius = geofenceDefaultRadius.obs;
  Rx<Set<Circle>> geofenceCircles = Rx<Set<Circle>>({});
  Rx<Set<Marker>> geofenceMarkers = Rx<Set<Marker>>({});
  String geofenceMapVehicleId = '';
  String geofenceMapDeviceId = '';
  bool isGeofenceDialogFromList = false;

  final CameraPosition geofenceInitialCameraPosition = const CameraPosition(
    target: geofenceCenterLocation,
    zoom: 15,
  );

  // Marker animation
  RxString selectedMotion = AppStrings.slowMotion.obs;

  // Generate report
  RxString selectedReportVehicle = ''.obs;
  RxString selectedReportType = ''.obs;
  RxString selectedDateRange = AppStrings.oneHrAgo.obs;
  RxBool showReportResults = false.obs;
  RxString reportSearchQuery = ''.obs;
  ReportSelectionDialogType reportSelectionDialogType =
      ReportSelectionDialogType.vehicle;
  final TextEditingController reportSearchController = TextEditingController();

  final List<String> reportVehicles =
      List.generate(8, (_) => 'DL2RQ-4235');

  final List<String> reportTypes = const [
    AppStrings.distanceReport,
    AppStrings.stopReport,
    AppStrings.idleReport,
    AppStrings.tripReport,
    AppStrings.overspeedReport,
    AppStrings.geofenceReport,
  ];

  final List<ReportTripItem> reportResults = List.generate(
    4,
    (_) => const ReportTripItem(
      startAddress: AppStrings.reportSampleAddress,
      startTime: '12:06 Am',
      endAddress: AppStrings.reportSampleAddress,
      endTime: '12:06 Am',
      avgSpeed: '21.16Km',
      duration: '00:00:30',
      maxSpeed: '21.16Km',
      distance: '21.16Km',
    ),
  );

  List<String> get filteredReportSelectionItems {
    final query = reportSearchQuery.value.trim().toLowerCase();
    final source = reportSelectionDialogType ==
            ReportSelectionDialogType.vehicle
        ? reportVehicles
        : reportTypes;
    if (query.isEmpty) return source;
    return source
        .where((item) => item.toLowerCase().contains(query))
        .toList();
  }

  String? getReportTypeIcon(String type) {
    switch (type) {
      case AppStrings.distanceReport:
        return Assets.reportDistance;
      case AppStrings.stopReport:
        return Assets.reportStop;
      case AppStrings.idleReport:
        return Assets.reportIdle;
      case AppStrings.tripReport:
        return Assets.reportTrip;
      case AppStrings.overspeedReport:
        return Assets.reportOverspeed;
      case AppStrings.geofenceReport:
        return Assets.reportGeofence;
      default:
        return null;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    geofenceNameController.dispose();
    reportSearchController.dispose();
    geofenceMapController?.dispose();
    super.onClose();
  }

  void onLogout() {}

  void onMenuTap(String title) {
    switch (title) {
      case AppStrings.generateReports:
        resetGenerateReportState();
        Get.toNamed(GenerateReportView.generateReportView);
        break;
      case AppStrings.geofence:
        Get.toNamed(GeofenceListView.geofenceListView);
        break;
      case AppStrings.markerAnimation:
        showMarkerAnimationDialog();
        break;
      case AppStrings.changePassword:
        Get.toNamed(ChangePasswordView.changePasswordView);
        break;
      case AppStrings.helpAndSupport:
        Get.toNamed(HelpSupportView.helpSupportView);
        break;
      case AppStrings.deleteAccount:
        showDeleteAccountDialog();
        break;
    }
  }

  void showDeleteAccountDialog() {
    Get.dialog(
      const DeleteAccountDialog(),
      barrierDismissible: true,
    );
  }

  void onDeleteAccountCancel() {
    Get.back();
  }

  void onDeleteAccountConfirm() {
    Get.back();
  }

  // Change password
  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void onChangePassword() {
    if (newPasswordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      return;
    }
    Get.back();
  }

  // Geofence list
  void onAddGeofence() {
    geofenceNameController.clear();
    isGeofenceDialogFromList = true;
    Get.dialog(const GeofenceCreateDialog(), barrierDismissible: false);
  }

  void onGeofenceDeviceTap(String deviceId) {
    _openGeofenceMap(vehicleId: geofenceVehicleId, deviceId: deviceId);
  }

  void _openGeofenceMap({required String vehicleId, String deviceId = ''}) {
    geofenceMapVehicleId = vehicleId;
    geofenceMapDeviceId = deviceId;
    initGeofenceMap();
    Get.toNamed(GeofenceMapView.geofenceMapView);
  }

  // Geofence map
  void initGeofenceMap() {
    geofenceRadius.value = geofenceDefaultRadius;
    _buildGeofenceOverlays();
  }

  void _buildGeofenceOverlays() {
    geofenceMarkers.value = {
      Marker(
        markerId: const MarkerId('geofence_center'),
        position: geofenceCenterLocation,
        icon: BitmapDescriptor.defaultMarker,
      ),
    };
    geofenceCircles.value = {
      Circle(
        circleId: const CircleId('geofence_circle'),
        center: geofenceCenterLocation,
        radius: geofenceRadius.value,
        fillColor: AppColors.geofenceCircleFillColor,
        strokeColor: Colors.black,
        strokeWidth: 2,
      ),
    };
  }

  void onGeofenceMapCreated(GoogleMapController controller) {
    geofenceMapController = controller;
  }

  void onGeofenceRadiusChanged(double value) {
    geofenceRadius.value = value;
    _buildGeofenceOverlays();
  }

  Future<void> goToGeofenceCenter() async {
    await geofenceMapController?.animateCamera(
      CameraUpdate.newCameraPosition(geofenceInitialCameraPosition),
    );
  }

  Future<void> geofenceZoomIn() async {
    final zoom = await geofenceMapController?.getZoomLevel() ?? 15;
    await geofenceMapController?.animateCamera(CameraUpdate.zoomTo(zoom + 1));
  }

  Future<void> geofenceZoomOut() async {
    final zoom = await geofenceMapController?.getZoomLevel() ?? 15;
    await geofenceMapController?.animateCamera(CameraUpdate.zoomTo(zoom - 1));
  }

  void onClearGeofence() {
    geofenceRadius.value = geofenceDefaultRadius;
    _buildGeofenceOverlays();
  }

  void onGeofencePolygonMode() {}

  void onGeofenceSaveTap() {
    geofenceNameController.clear();
    isGeofenceDialogFromList = false;
    Get.dialog(const GeofenceCreateDialog(), barrierDismissible: false);
  }

  void onGeofenceCancelDialog() {
    Get.back();
  }

  void onSaveGeofence() {
    if (geofenceNameController.text.trim().isEmpty) return;
    Get.back();
    if (isGeofenceDialogFromList) {
      _openGeofenceMap(vehicleId: geofenceVehicleId);
    } else {
      Get.back();
    }
  }

  // Marker animation
  void showMarkerAnimationDialog() {
    selectedMotion.value = AppStrings.slowMotion;
    Get.dialog(
      const MarkerAnimationDialog(),
      barrierDismissible: true,
    );
  }

  void selectMotion(String motion) {
    selectedMotion.value = motion;
  }

  void onMarkerAnimationCancel() {
    Get.back();
  }

  void onMarkerAnimationOk() {
    Get.back();
  }

  // Generate report
  void showVehicleSelectionDialog() {
    reportSelectionDialogType = ReportSelectionDialogType.vehicle;
    reportSearchController.clear();
    reportSearchQuery.value = '';
    Get.dialog(
      const ReportSelectionDialog(),
      barrierDismissible: true,
    );
  }

  void showReportTypeSelectionDialog() {
    reportSelectionDialogType = ReportSelectionDialogType.reportType;
    reportSearchController.clear();
    reportSearchQuery.value = '';
    Get.dialog(
      const ReportSelectionDialog(),
      barrierDismissible: true,
    );
  }

  void onReportSearchChanged(String value) {
    reportSearchQuery.value = value;
  }

  void onReportItemSelected(String item) {
    if (reportSelectionDialogType == ReportSelectionDialogType.vehicle) {
      selectedReportVehicle.value = item;
      Get.back();
      return;
    }

    selectedReportType.value = item;
    Get.back();
    Future.microtask(showDateSelectionDialog);
  }

  void resetGenerateReportState() {
    selectedReportVehicle.value = '';
    selectedReportType.value = '';
    selectedDateRange.value = AppStrings.oneHrAgo;
    showReportResults.value = false;
    reportSearchController.clear();
    reportSearchQuery.value = '';
  }

  void showDateSelectionDialog() {
    selectedDateRange.value = AppStrings.oneHrAgo;
    Get.dialog(
      const ReportDateSelectionDialog(),
      barrierDismissible: true,
    );
  }

  void selectDateRange(String range) {
    selectedDateRange.value = range;
  }

  void onDateSelectionClose() {
    Get.back();
  }

  void onDateSelectionOk() {
    Get.back();
  }

  void onGenerateReportSearch() {
    if (selectedReportVehicle.value.isEmpty ||
        selectedReportType.value.isEmpty ||
        selectedDateRange.value.isEmpty) {
      return;
    }
    showReportResults.value = true;
  }

  // Help & support
  void onPhoneTap() {}
  void onWhatsAppTap() {}
  void onGmailTap() {}
  void onEmailTap() {}
}
