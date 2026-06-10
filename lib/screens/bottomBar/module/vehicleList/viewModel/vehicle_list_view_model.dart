import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/over_speed/widget/over_speed_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/share_location/view/share_location_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/share_location/widget/share_location_edit_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/share_location/widget/share_location_option_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_detail/view/vehicle_detail_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/distance_report/view/distance_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/idle_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/stop_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/geofence_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/overspeed_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/trip_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/vehicle_reports_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/widget/vehicle_report_date_selection_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/view/live_track_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/widget/fuel_cutoff_success_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/widget/geofence_confirm_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/widget/immobilize_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_menu/view/vehicle_menu_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/view/playback_vehicle_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/view/alert_option_setting_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/view/vehicle_notification_view.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/base_controller.dart';

class VehicleDetailInfo {
  final String name;
  final String imei;
  final String simCard;
  final String model;
  final String activationTime;
  final String expireDate;
  final String status;
  final String gpsTime;
  final String latestUpdate;
  final String speed;
  final String coordinate;
  final String engineStatus;

  const VehicleDetailInfo({
    required this.name,
    required this.imei,
    required this.simCard,
    required this.model,
    required this.activationTime,
    required this.expireDate,
    required this.status,
    required this.gpsTime,
    required this.latestUpdate,
    required this.speed,
    required this.coordinate,
    required this.engineStatus,
  });
}

class TimedReportItem {
  final String date;
  final String address;
  final String startTime;
  final String endTime;
  final String duration;

  const TimedReportItem({
    required this.date,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });
}

class VehicleOverSpeedReportItem {
  final String startAddress;
  final String startTime;
  final String endAddress;
  final String endTime;
  final String startSpeed;
  final String duration;
  final String endSpeed;
  final String distance;

  const VehicleOverSpeedReportItem({
    required this.startAddress,
    required this.startTime,
    required this.endAddress,
    required this.endTime,
    required this.startSpeed,
    required this.duration,
    required this.endSpeed,
    required this.distance,
  });
}

class VehicleTripReportItem {
  final String startAddress;
  final String startTime;
  final String endAddress;
  final String endTime;
  final String avgSpeed;
  final String duration;
  final String maxSpeed;
  final String distance;

  const VehicleTripReportItem({
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

class GeofenceReportItem {
  final String vehicleId;
  final String dateTime;
  final String address;

  const GeofenceReportItem({
    required this.vehicleId,
    required this.dateTime,
    required this.address,
  });
}

class DistanceReportItem {
  final String date;
  final String startAddress;
  final String endAddress;
  final String distance;

  const DistanceReportItem({
    required this.date,
    required this.startAddress,
    required this.endAddress,
    required this.distance,
  });
}

class VehicleReportItem {
  final String title;
  final String icon;

  const VehicleReportItem({
    required this.title,
    required this.icon,
  });
}

class ShareLocationItem {
  final String shareId;
  final String shareName;
  final String validTill;
  final String status;

  const ShareLocationItem({
    required this.shareId,
    required this.shareName,
    required this.validTill,
    required this.status,
  });
}

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

class LiveTrackVehicleInfo {
  final String vehicleId;
  final String vehicleCode;
  final String time;
  final String status;
  final String engine;
  final String externalPower;
  final String distance;
  final String todayKm;
  final String speed;
  final String address;
  final double latitude;
  final double longitude;

  const LiveTrackVehicleInfo({
    required this.vehicleId,
    required this.vehicleCode,
    required this.time,
    required this.status,
    required this.engine,
    required this.externalPower,
    required this.distance,
    required this.todayKm,
    required this.speed,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class AlertOptionItem {
  final String title;
  final RxBool enabled;

  AlertOptionItem({
    required this.title,
    required bool initialValue,
  }) : enabled = initialValue.obs;
}

class VehicleListItem {
  final String name;
  final String vehicleId;
  final String imei;
  final String status;
  final bool isPwrOn;
  final bool isGpsOn;
  final bool isIgnOn;

  const VehicleListItem({
    required this.name,
    required this.vehicleId,
    required this.imei,
    required this.status,
    required this.isPwrOn,
    required this.isGpsOn,
    required this.isIgnOn,
  });
}

class VehicleListViewModel extends BaseController {
  static const LatLng liveTrackDefaultLocation = LatLng(28.7041, 77.2650);
  static const double liveTrackDefaultZoom = 15;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController overSpeedController = TextEditingController();
  final TextEditingController immobilizePasswordController =
      TextEditingController();
  GoogleMapController? liveTrackMapController;
  Timer? _liveTrackRefreshTimer;
  RxInt selectedFilterIndex = 0.obs;
  Rxn<VehicleListItem> selectedVehicle = Rxn<VehicleListItem>();
  Rxn<ShareLocationItem> editingShareLocation = Rxn<ShareLocationItem>();
  RxString selectedVehicleReportType = ''.obs;
  RxString selectedVehicleReportDateRange = AppStrings.oneHrAgo.obs;
  bool isOverSpeedDialogFromReport = false;
  RxInt liveTrackRefreshSeconds = 10.obs;
  Rx<MapType> liveTrackMapType = MapType.normal.obs;
  Rx<Set<Marker>> liveTrackMarkers = Rx<Set<Marker>>({});
  RxString liveTrackAddress = AppStrings.sampleLiveTrackAddress.obs;

  final CameraPosition liveTrackCameraPosition = const CameraPosition(
    target: liveTrackDefaultLocation,
    zoom: liveTrackDefaultZoom,
  );

  LiveTrackVehicleInfo? get liveTrackInfo {
    final vehicle = selectedVehicle.value;
    if (vehicle == null) return null;
    return LiveTrackVehicleInfo(
      vehicleId: vehicle.vehicleId,
      vehicleCode: AppStrings.sampleVehicleCode,
      time: AppStrings.sampleLiveTrackTime,
      status: AppStrings.sampleRunningStatus,
      engine: AppStrings.off.toUpperCase(),
      externalPower: AppStrings.on.toUpperCase(),
      distance: AppStrings.sampleLiveDistance,
      todayKm: AppStrings.sampleTodayKm,
      speed: AppStrings.sampleLiveSpeed,
      address: AppStrings.sampleLiveTrackAddress,
      latitude: liveTrackDefaultLocation.latitude,
      longitude: liveTrackDefaultLocation.longitude,
    );
  }

  RxBool receiveNotificationEnabled = false.obs;
  RxBool voiceNotificationEnabled = false.obs;

  final List<AlertOptionItem> alertOptions = [
    AlertOptionItem(title: AppStrings.ignition, initialValue: true),
    AlertOptionItem(title: AppStrings.ac, initialValue: true),
    AlertOptionItem(title: AppStrings.overSpeed, initialValue: true),
    AlertOptionItem(title: AppStrings.power, initialValue: true),
    AlertOptionItem(title: AppStrings.temper, initialValue: true),
    AlertOptionItem(title: AppStrings.sos, initialValue: true),
    AlertOptionItem(title: AppStrings.geofence, initialValue: true),
    AlertOptionItem(title: AppStrings.immobilizer, initialValue: true),
    AlertOptionItem(title: AppStrings.parking, initialValue: true),
    AlertOptionItem(title: AppStrings.door, initialValue: true),
    AlertOptionItem(title: AppStrings.promotion, initialValue: true),
  ];

  final String totalDistanceValue = AppStrings.sampleDistanceValue;

  final List<DistanceReportItem> distanceReportItems = const [
    DistanceReportItem(
      date: AppStrings.sampleReportDate,
      startAddress: AppStrings.sampleDistanceAddress,
      endAddress: AppStrings.sampleDistanceAddress,
      distance: AppStrings.sampleDistanceValue,
    ),
  ];

  final List<TimedReportItem> stopReportItems = const [
    TimedReportItem(
      date: AppStrings.sampleTimedReportDate,
      address: AppStrings.sampleDistanceAddress,
      startTime: AppStrings.sampleReportTime,
      endTime: AppStrings.sampleReportTime,
      duration: AppStrings.sampleReportDuration,
    ),
  ];

  final List<TimedReportItem> idleReportItems = const [
    TimedReportItem(
      date: AppStrings.sampleTimedReportDate,
      address: AppStrings.sampleDistanceAddress,
      startTime: AppStrings.sampleReportTime,
      endTime: AppStrings.sampleReportTime,
      duration: AppStrings.sampleReportDuration,
    ),
  ];

  final List<VehicleTripReportItem> tripReportItems = const [
    VehicleTripReportItem(
      startAddress: AppStrings.reportSampleAddress,
      startTime: AppStrings.sampleReportTime,
      endAddress: AppStrings.reportSampleAddress,
      endTime: AppStrings.sampleReportTime,
      avgSpeed: '21.16Km',
      duration: '00:00:30',
      maxSpeed: '21.16Km',
      distance: '21.16Km',
    ),
  ];

  final List<VehicleOverSpeedReportItem> overspeedReportItems = const [
    VehicleOverSpeedReportItem(
      startAddress: AppStrings.reportSampleAddress,
      startTime: AppStrings.sampleReportTime,
      endAddress: AppStrings.reportSampleAddress,
      endTime: AppStrings.sampleReportTime,
      startSpeed: '21.16Km',
      duration: '00:00:30',
      endSpeed: '21.16Km',
      distance: '21.16Km',
    ),
  ];

  final List<GeofenceReportItem> geofenceReportItems = List.generate(
    6,
    (_) => const GeofenceReportItem(
      vehicleId: AppStrings.sampleVehicleName,
      dateTime: AppStrings.sampleGeofenceDateTime,
      address: AppStrings.sampleDistanceAddress,
    ),
  );

  final List<VehicleReportItem> vehicleReportItems = const [
    VehicleReportItem(
      title: AppStrings.distanceReports,
      icon: Assets.reportDistance,
    ),
    VehicleReportItem(
      title: AppStrings.stopReports,
      icon: Assets.reportStop,
    ),
    VehicleReportItem(
      title: AppStrings.idleReports,
      icon: Assets.reportIdle,
    ),
    VehicleReportItem(
      title: AppStrings.tripReports,
      icon: Assets.reportTrip,
    ),
    VehicleReportItem(
      title: AppStrings.overspeedReports,
      icon: Assets.reportOverspeed,
    ),
    VehicleReportItem(
      title: AppStrings.geofenceReports,
      icon: Assets.reportDistance,
    ),
  ];

  final List<ShareLocationItem> shareLocationItems = const [
    ShareLocationItem(
      shareId: AppStrings.sampleVehicleName,
      shareName: AppStrings.sampleVehicleName,
      validTill: AppStrings.sampleShareTimestamp,
      status: AppStrings.active,
    ),
  ];

  VehicleDetailInfo get vehicleDetail {
    final vehicle = selectedVehicle.value;
    return VehicleDetailInfo(
      name: AppStrings.sampleVehicleName,
      imei: vehicle?.imei ?? AppStrings.sampleImei,
      simCard: AppStrings.sampleSimCard,
      model: AppStrings.sampleModel,
      activationTime: AppStrings.sampleDateTime,
      expireDate: AppStrings.sampleExpireDate,
      status: AppStrings.sampleOfflineStatus,
      gpsTime: AppStrings.sampleGpsTime,
      latestUpdate: AppStrings.sampleExpireDate,
      speed: AppStrings.sampleSpeed,
      coordinate: AppStrings.sampleCoordinate,
      engineStatus: AppStrings.sampleDateTime,
    );
  }

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
      bgColor: AppColors.stopColor.withValues(alpha: 0.35),
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
      vehicleId: 'DL2RQ-3478',
      imei: AppStrings.sampleImei,
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE141',
      vehicleId: 'DL2RQ-3479',
      imei: AppStrings.sampleImei,
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE142',
      vehicleId: 'DL2RQ-3480',
      imei: AppStrings.sampleImei,
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE143',
      vehicleId: 'DL2RQ-3481',
      imei: AppStrings.sampleImei,
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE144',
      vehicleId: 'DL2RQ-3482',
      imei: AppStrings.sampleImei,
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
    VehicleListItem(
      name: 'ACUTE145',
      vehicleId: 'DL2RQ-3483',
      imei: AppStrings.sampleImei,
      status: 'Offline (22 Min, 39 Sec)',
      isPwrOn: false,
      isGpsOn: true,
      isIgnOn: true,
    ),
  ];

  void onVehicleTap(VehicleListItem vehicle) {
    selectedVehicle.value = vehicle;
    Get.toNamed(VehicleMenuView.vehicleMenuView);
  }

  void onVehicleMenuTap(String menuTitle) {
    switch (menuTitle) {
      case AppStrings.detail:
        Get.toNamed(VehicleDetailView.vehicleDetailView);
        break;
      case AppStrings.shareLocation:
        showShareLocationOptionDialog();
        break;
      case AppStrings.overSpeed:
        showOverSpeedDialog();
        break;
      case AppStrings.reports:
        Get.toNamed(VehicleReportsView.vehicleReportsView);
        break;
      case AppStrings.alert:
        Get.toNamed(VehicleNotificationView.vehicleNotificationView);
        break;
      case AppStrings.tracking:
        initLiveTrack();
        Get.toNamed(LiveTrackView.liveTrackView);
        break;
      case AppStrings.playback:
        Get.toNamed(PlaybackVehicleView.playbackVehicleView);
        break;
    }
  }

  void initLiveTrack() {
    liveTrackAddress.value = AppStrings.sampleLiveTrackAddress;
    liveTrackMapType.value = MapType.normal;
    _buildLiveTrackMarker();
    _startLiveTrackRefreshTimer();
  }

  void _buildLiveTrackMarker() {
    final info = liveTrackInfo;
    if (info == null) return;

    liveTrackMarkers.value = {
      Marker(
        markerId: MarkerId(info.vehicleId),
        position: LatLng(info.latitude, info.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    };
  }

  void _startLiveTrackRefreshTimer() {
    _liveTrackRefreshTimer?.cancel();
    liveTrackRefreshSeconds.value = 10;
    _liveTrackRefreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (liveTrackRefreshSeconds.value <= 1) {
        onLiveTrackRefresh();
      } else {
        liveTrackRefreshSeconds.value--;
      }
    });
  }

  void onLiveTrackMapCreated(GoogleMapController controller) {
    liveTrackMapController = controller;
  }

  Future<void> liveTrackZoomIn() async {
    final zoom =
        await liveTrackMapController?.getZoomLevel() ?? liveTrackDefaultZoom;
    await liveTrackMapController?.animateCamera(CameraUpdate.zoomTo(zoom + 1));
  }

  Future<void> liveTrackZoomOut() async {
    final zoom =
        await liveTrackMapController?.getZoomLevel() ?? liveTrackDefaultZoom;
    await liveTrackMapController?.animateCamera(CameraUpdate.zoomTo(zoom - 1));
  }

  Future<void> goToLiveTrackVehicle() async {
    await liveTrackMapController?.animateCamera(
      CameraUpdate.newCameraPosition(liveTrackCameraPosition),
    );
  }

  void toggleLiveTrackMapType() {
    const types = [
      MapType.normal,
      MapType.satellite,
      MapType.terrain,
      MapType.hybrid,
    ];
    final currentIndex = types.indexOf(liveTrackMapType.value);
    liveTrackMapType.value = types[(currentIndex + 1) % types.length];
  }

  void onLiveTrackRefresh() {
    liveTrackRefreshSeconds.value = 10;
    goToLiveTrackVehicle();
    _buildLiveTrackMarker();
  }

  void showImmobilizeDialog() {
    immobilizePasswordController.clear();
    Get.dialog(const ImmobilizeDialog(), barrierDismissible: true);
  }

  void onImmobilizeCancel() {
    Get.back();
  }

  void onFuelSupplyCutOff() {
    if (immobilizePasswordController.text.trim().isEmpty) return;
    Get.back();
    Future.microtask(() {
      Get.dialog(
        const FuelCutoffSuccessDialog(),
        barrierDismissible: false,
      );
    });
  }

  void onFuelCutoffContinue() {
    Get.back();
  }

  void showGeofenceConfirmDialog() {
    Get.dialog(const GeofenceConfirmDialog(), barrierDismissible: true);
  }

  void onGeofenceConfirmNo() {
    Get.back();
  }

  void onGeofenceConfirmYes() {
    Get.back();
  }

  void stopLiveTrackRefresh() {
    _liveTrackRefreshTimer?.cancel();
    _liveTrackRefreshTimer = null;
  }

  void _disposeLiveTrack() {
    stopLiveTrackRefresh();
    liveTrackMapController?.dispose();
    liveTrackMapController = null;
  }

  void onReceiveNotificationChanged(bool value) {
    receiveNotificationEnabled.value = value;
  }

  void onVoiceNotificationChanged(bool value) {
    voiceNotificationEnabled.value = value;
  }

  void onAlertOptionSettingTap() {
    Get.toNamed(AlertOptionSettingView.alertOptionSettingView);
  }

  void onAlertOptionChanged(int index, bool value) {
    alertOptions[index].enabled.value = value;
  }

  void onAlertOptionSave() {
    Get.back();
  }

  void onVehicleReportTap(String reportTitle) {
    selectedVehicleReportType.value = reportTitle;
    if (reportTitle == AppStrings.overspeedReports) {
      showOverSpeedDialog(fromReport: true);
      return;
    }
    showVehicleReportDateSelectionDialog();
  }

  void showVehicleReportDateSelectionDialog() {
    selectedVehicleReportDateRange.value = AppStrings.oneHrAgo;
    Get.dialog(
      const VehicleReportDateSelectionDialog(),
      barrierDismissible: true,
    );
  }

  void selectVehicleReportDateRange(String range) {
    selectedVehicleReportDateRange.value = range;
  }

  void onVehicleReportDateSelectionClose() {
    Get.back();
  }

  void onVehicleReportDateSelectionOk() {
    Get.back();
    _openVehicleReportScreen();
  }

  void _openVehicleReportScreen() {
    switch (selectedVehicleReportType.value) {
      case AppStrings.distanceReports:
        Get.toNamed(DistanceReportView.distanceReportView);
        break;
      case AppStrings.stopReports:
        Get.toNamed(StopReportView.stopReportView);
        break;
      case AppStrings.idleReports:
        Get.toNamed(IdleReportView.idleReportView);
        break;
      case AppStrings.tripReports:
        Get.toNamed(TripReportView.tripReportView);
        break;
      case AppStrings.overspeedReports:
        Get.toNamed(OverspeedReportView.overspeedReportView);
        break;
      case AppStrings.geofenceReports:
        Get.toNamed(GeofenceReportView.geofenceReportView);
        break;
      default:
        break;
    }
  }

  void onDistanceReportDownload() {}

  void onStopReportDownload() {}

  void onIdleReportDownload() {}

  void onTripReportDownload() {}

  void onOverspeedReportDownload() {}

  void onGeofenceReportDownload() {}

  void showOverSpeedDialog({bool fromReport = false}) {
    isOverSpeedDialogFromReport = fromReport;
    overSpeedController.text = '0';
    Get.dialog(
      const OverSpeedDialog(),
      barrierDismissible: true,
    );
  }

  void onOverSpeedCancel() {
    isOverSpeedDialogFromReport = false;
    Get.back();
  }

  void onOverSpeedSubmit() {
    final openDateDialog = isOverSpeedDialogFromReport;
    isOverSpeedDialogFromReport = false;
    Get.back();
    if (openDateDialog) {
      Future.microtask(showVehicleReportDateSelectionDialog);
    }
  }

  void onVehicleDetailEdit() {}

  void showShareLocationOptionDialog() {
    Get.dialog(
      const ShareLocationOptionDialog(),
      barrierDismissible: true,
    );
  }

  void onShareLocationOptionCancel() {
    Get.back();
  }

  void onShareLocationDuration() {
    Get.back();
    Get.toNamed(ShareLocationView.shareLocationView);
  }

  void onShareLocationCurrent() {
    Get.back();
    Get.toNamed(ShareLocationView.shareLocationView);
  }

  void onShareLocationItemTap(ShareLocationItem item) {
    editingShareLocation.value = item;
    Get.dialog(
      const ShareLocationEditDialog(),
      barrierDismissible: true,
    );
  }

  void onAddShareLocation() {
    editingShareLocation.value = const ShareLocationItem(
      shareId: AppStrings.sampleVehicleName,
      shareName: AppStrings.sampleVehicleName,
      validTill: AppStrings.sampleShareTimestamp,
      status: AppStrings.active,
    );
    Get.dialog(
      const ShareLocationEditDialog(),
      barrierDismissible: true,
    );
  }

  void onShareLocationValidTillTap() {}

  void onShareLocationSave() {
    Get.back();
  }

  @override
  void onClose() {
    _disposeLiveTrack();
    searchController.dispose();
    overSpeedController.dispose();
    immobilizePasswordController.dispose();
    super.onClose();
  }
}
