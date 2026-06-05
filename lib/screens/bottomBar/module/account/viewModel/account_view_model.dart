import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/change_password/view/change_password_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/view/geofence_list_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/view/geofence_map_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_create_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/view/help_support_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/marker_animation/marker_animation_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/account/widget/delete_account_dialog.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/base_controller.dart';

class AccountMenuItem {
  final IconData icon;
  final String title;

  const AccountMenuItem({
    required this.icon,
    required this.title,
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

  final List<AccountMenuItem> menuItems = const [
    AccountMenuItem(
      icon: Icons.bar_chart,
      title: AppStrings.generateReports,
    ),
    AccountMenuItem(
      icon: Icons.grid_on,
      title: AppStrings.geofence,
    ),
    AccountMenuItem(
      icon: Icons.animation,
      title: AppStrings.markerAnimation,
    ),
    AccountMenuItem(
      icon: Icons.settings,
      title: AppStrings.changePassword,
    ),
    AccountMenuItem(
      icon: Icons.support_agent,
      title: AppStrings.helpAndSupport,
    ),
    AccountMenuItem(
      icon: Icons.person_remove_outlined,
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

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    geofenceNameController.dispose();
    geofenceMapController?.dispose();
    super.onClose();
  }

  void onLogout() {}

  void onMenuTap(String title) {
    switch (title) {
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

  // Help & support
  void onPhoneTap() {}
  void onWhatsAppTap() {}
  void onGmailTap() {}
  void onEmailTap() {}
}
