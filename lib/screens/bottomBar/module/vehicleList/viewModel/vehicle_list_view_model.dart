import 'dart:async';
import 'dart:math';

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
import 'package:gps_software/screens/bottomBar/module/map/helper/map_vehicle_marker_icon.dart';
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
  final double rotation;
  final MapVehicleMarkerStatus markerStatus;

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
    required this.rotation,
    required this.markerStatus,
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
  static const List<double> _liveTrackRotations = [
    0,
    45,
    90,
    135,
    180,
    225,
    270,
    315,
  ];

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
  final liveTrackMarkers = <Marker>{}.obs;
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
      rotation: _liveTrackMarkerRotation(vehicle.vehicleId),
      markerStatus: mapVehicleMarkerStatusFromLabel(vehicle.status),
    );
  }

  double _liveTrackMarkerRotation(String vehicleId) {
    return _liveTrackRotations[
      vehicleId.hashCode.abs() % _liveTrackRotations.length
    ];
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
        initPlayback();
        Get.toNamed(PlaybackVehicleView.playbackVehicleView);
        break;
    }
  }

  void initLiveTrack() {
    liveTrackAddress.value = AppStrings.sampleLiveTrackAddress;
    liveTrackMapType.value = MapType.normal;
    _loadLiveTrackMarker();
    _startLiveTrackRefreshTimer();
  }

  Future<void> _loadLiveTrackMarker() async {
    await MapVehicleMarkerIcon.load();
    _buildLiveTrackMarker();
  }

  void _buildLiveTrackMarker() {
    final info = liveTrackInfo;
    if (info == null || !MapVehicleMarkerIcon.isLoaded) return;

    final marker = MapVehicleMarkerIcon.toMarker(
      MapVehicleMarker(
        id: info.vehicleId,
        latitude: info.latitude,
        longitude: info.longitude,
        status: info.markerStatus,
        address: info.address,
        rotation: info.rotation,
      ),
    );

    liveTrackMarkers
      ..clear()
      ..add(marker);
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
    if (MapVehicleMarkerIcon.isLoaded) {
      _buildLiveTrackMarker();
    }
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

  // ══════════════════════════════════════════════════════════════════════════
  // ── Playback Animation State ─────────────────────────────────────────────
  // ══════════════════════════════════════════════════════════════════════════

  /// Dummy route through New Delhi for playback demonstration
  static const List<LatLng> playbackRoute = [
    LatLng(28.7041, 77.2650),
    LatLng(28.7055, 77.2665),
    LatLng(28.7070, 77.2680),
    LatLng(28.7090, 77.2700),
    LatLng(28.7105, 77.2720),
    LatLng(28.7115, 77.2745),
    LatLng(28.7125, 77.2770),
    LatLng(28.7140, 77.2790),
    LatLng(28.7155, 77.2810),
    LatLng(28.7165, 77.2835),
    LatLng(28.7175, 77.2855),
    LatLng(28.7185, 77.2870),
    LatLng(28.7200, 77.2885),
    LatLng(28.7215, 77.2900),
    LatLng(28.7230, 77.2920),
  ];

  GoogleMapController? playbackMapController;
  Timer? _playbackTimer;

  final RxBool playbackIsPlaying = false.obs;
  final RxInt playbackCurrentIndex = 0.obs;
  final RxString playbackSelectedSpeed = AppStrings.normal.obs;
  final Rx<Set<Marker>> playbackMarkers = Rx<Set<Marker>>({});
  final Rx<Set<Polyline>> playbackPolylines = Rx<Set<Polyline>>({});
  final Rx<MapType> playbackMapType = MapType.normal.obs;
  static const int playbackParkingIndex = 5;
  static const Size playbackFlagIconSize = Size(50, 36);
  static const Offset playbackStartFlagAnchor = Offset(0.04, 0.92);
  static const Offset playbackEndFlagAnchor = Offset(0.04, 0.92);
  static const Size playbackVehicleIconSize = Size(40, 40);
  static const Size playbackParkingIconSize = Size(36, 48);
  static const Offset playbackParkingAnchor = Offset(0.5, 1.0);
  static const double playbackVehicleRotationOffset = -45;
  BitmapDescriptor? _playbackStartMarkerIcon;
  BitmapDescriptor? _playbackEndMarkerIcon;
  BitmapDescriptor? _playbackVehicleMarkerIcon;
  BitmapDescriptor? _playbackParkingMarkerIcon;
  bool _playbackMarkerIconsLoaded = false;

  // Current playback info (updated as vehicle moves)
  final RxString playbackSpeed = '0.0 Km/h'.obs;
  final RxString playbackMileage = '0.00 Km'.obs;
  final RxString playbackGpsTime = '2023-07-14 10:05:26'.obs;
  final RxString playbackAddress = ''.obs;

  /// Addresses corresponding to each point in the dummy route
  static const List<String> _routeAddresses = [
    'Yamuna Vihar, Shahdara, New Delhi, Delhi 110053, India',
    'Block C, Yamuna Vihar, Shahdara, New Delhi, Delhi 110053, India',
    'Bhagwan Shree Pashuram Rd, Block C, Yamuna Vihar, New Delhi, India',
    'Wazirabad Rd, Yamuna Vihar, Shahdara, New Delhi, India',
    'Bhajanpura, Shahdara, New Delhi, Delhi 110053, India',
    'Loni Rd, Bhajanpura, New Delhi, Delhi 110053, India',
    'Maujpur, Shahdara, New Delhi, Delhi 110053, India',
    'Jyoti Nagar, Shahdara, New Delhi, Delhi 110053, India',
    'Dilshad Colony, Shahdara, New Delhi, Delhi 110096, India',
    'GT Road, Dilshad Garden, New Delhi, Delhi 110095, India',
    'Seemapuri, Shahdara, New Delhi, Delhi 110095, India',
    'Raj Bagh, Shahdara, New Delhi, Delhi 110095, India',
    'Nand Nagri, Shahdara, New Delhi, Delhi 110093, India',
    'Sunder Nagri, Shahdara, New Delhi, Delhi 110093, India',
    'Harsh Vihar, Shahdara, New Delhi, Delhi 110093, India',
  ];

  /// Calculate distance in km between two LatLng points using Haversine formula
  double _haversineDistance(LatLng a, LatLng b) {
    const R = 6371.0; // Earth radius in km
    final dLat = (b.latitude - a.latitude) * pi / 180;
    final dLon = (b.longitude - a.longitude) * pi / 180;
    final sinDLat = sin(dLat / 2);
    final sinDLon = sin(dLon / 2);
    final aVal = sinDLat * sinDLat +
        cos(a.latitude * pi / 180) *
            cos(b.latitude * pi / 180) *
            sinDLon *
            sinDLon;
    final c = 2 * atan2(sqrt(aVal), sqrt(1 - aVal));
    return R * c;
  }

  /// Initialise playback state when entering the playback screen
  void initPlayback() {
    playbackCurrentIndex.value = 0;
    playbackIsPlaying.value = false;
    playbackSelectedSpeed.value = AppStrings.normal;
    playbackMapType.value = MapType.normal;
    playbackAddress.value = AppStrings.sampleLiveTrackAddress;
    _loadPlaybackData();
  }

  Future<void> _loadPlaybackData() async {
    await _loadPlaybackMarkerIcons();
    _updatePlaybackMarkers();
    _updatePlaybackPolylines();
    _updatePlaybackInfo();
  }

  Future<void> _loadPlaybackMarkerIcons() async {
    if (_playbackMarkerIconsLoaded) return;

    _playbackStartMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: playbackFlagIconSize),
      Assets.playbackStartIcon,
    );
    _playbackEndMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: playbackFlagIconSize),
      Assets.playbackEndIcon,
    );
    _playbackVehicleMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: playbackVehicleIconSize),
      Assets.playbackVehicleIcon,
    );
    _playbackParkingMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: playbackParkingIconSize),
      Assets.playbackParkingIcon,
    );
    _playbackMarkerIconsLoaded = true;
  }

  String get playbackSpeedLabel {
    switch (playbackSelectedSpeed.value) {
      case AppStrings.slow:
        return '0.5X';
      case AppStrings.normal:
        return AppStrings.speed1x;
      case AppStrings.fastSpeed:
        return '2X';
      case AppStrings.veryFast:
        return '4X';
      default:
        return AppStrings.speed1x;
    }
  }

  void onPlaybackSeek(int index) {
    final maxIndex = playbackRoute.length - 1;
    playbackCurrentIndex.value = index.clamp(0, maxIndex);
    _updatePlaybackMarkers();
    _updatePlaybackPolylines();
    _updatePlaybackInfo();
    playbackMapController?.animateCamera(
      CameraUpdate.newLatLng(playbackRoute[playbackCurrentIndex.value]),
    );
  }

  void togglePlaybackMapType() {
    const types = [
      MapType.normal,
      MapType.satellite,
      MapType.terrain,
      MapType.hybrid,
    ];
    final currentIndex = types.indexOf(playbackMapType.value);
    playbackMapType.value = types[(currentIndex + 1) % types.length];
  }

  Future<void> playbackZoomIn() async {
    final zoom = await playbackMapController?.getZoomLevel() ?? 14;
    await playbackMapController?.animateCamera(CameraUpdate.zoomTo(zoom + 1));
  }

  Future<void> playbackZoomOut() async {
    final zoom = await playbackMapController?.getZoomLevel() ?? 14;
    await playbackMapController?.animateCamera(CameraUpdate.zoomTo(zoom - 1));
  }

  void onPlaybackMapCreated(GoogleMapController controller) {
    playbackMapController = controller;
    // Fit the map to show the full route
    _fitPlaybackRoute();
  }

  void _fitPlaybackRoute() {
    if (playbackRoute.length < 2) return;
    double minLat = playbackRoute.first.latitude;
    double maxLat = playbackRoute.first.latitude;
    double minLng = playbackRoute.first.longitude;
    double maxLng = playbackRoute.first.longitude;
    for (final p in playbackRoute) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    playbackMapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        60,
      ),
    );
  }

  double _bearing(LatLng a, LatLng b) {
    final dLon = (b.longitude - a.longitude) * pi / 180;
    final lat1 = a.latitude * pi / 180;
    final lat2 = b.latitude * pi / 180;
    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    return (atan2(y, x) * 180 / pi + 360) % 360;
  }

  void _updatePlaybackMarkers() {
    final idx = playbackCurrentIndex.value;
    final currentPos = playbackRoute[idx];
    final startPos = playbackRoute.first;
    final endPos = playbackRoute.last;

    double rotation = 0;
    if (idx < playbackRoute.length - 1) {
      rotation = _bearing(playbackRoute[idx], playbackRoute[idx + 1]);
    } else if (idx > 0) {
      rotation = _bearing(playbackRoute[idx - 1], playbackRoute[idx]);
    }
    rotation =
        (rotation + playbackVehicleRotationOffset + 360) % 360;

    final startIcon = _playbackStartMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    final endIcon = _playbackEndMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    final vehicleIcon = _playbackVehicleMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    final parkingIcon = _playbackParkingMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);

    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('playback_start'),
        position: startPos,
        icon: startIcon,
        infoWindow: InfoWindow(title: AppStrings.startPlayback),
        anchor: playbackStartFlagAnchor,
        zIndexInt: 2,
      ),
      Marker(
        markerId: const MarkerId('playback_end'),
        position: endPos,
        icon: endIcon,
        infoWindow: InfoWindow(title: AppStrings.end.toUpperCase()),
        anchor: playbackEndFlagAnchor,
        zIndexInt: 2,
      ),
      if (playbackParkingIndex < playbackRoute.length)
        Marker(
          markerId: const MarkerId('playback_parking'),
          position: playbackRoute[playbackParkingIndex],
          icon: parkingIcon,
          infoWindow: InfoWindow(title: AppStrings.parking),
          anchor: playbackParkingAnchor,
          zIndexInt: 3,
        ),
      Marker(
        markerId: const MarkerId('playback_vehicle'),
        position: currentPos,
        icon: vehicleIcon,
        rotation: rotation,
        anchor: const Offset(0.5, 0.5),
        flat: true,
        zIndexInt: 10,
      ),
    };

    playbackMarkers.value = markers;
  }

  void _updatePlaybackPolylines() {
    playbackPolylines.value = {
      Polyline(
        polylineId: const PolylineId('playback_route'),
        points: playbackRoute,
        color: AppColors.playbackRouteColor,
        width: 5,
      ),
    };
  }

  void _updatePlaybackInfo() {
    final idx = playbackCurrentIndex.value;

    // Calculate cumulative mileage
    double totalDist = 0;
    for (int i = 1; i <= idx; i++) {
      totalDist += _haversineDistance(playbackRoute[i - 1], playbackRoute[i]);
    }

    // Simulate speed based on distance between consecutive points
    double speedVal = 0;
    if (idx > 0) {
      final segDist =
          _haversineDistance(playbackRoute[idx - 1], playbackRoute[idx]);
      speedVal = segDist * 120; // Scale up for realistic speed display
    }

    // Simulate GPS time incrementing
    final baseTime = DateTime(2023, 7, 14, 10, 5, 26);
    final gpsTime = baseTime.add(Duration(seconds: idx * 30));

    playbackSpeed.value = '${speedVal.toStringAsFixed(1)} Km/h';
    playbackMileage.value = '${totalDist.toStringAsFixed(2)} Km';
    playbackGpsTime.value =
        '${gpsTime.year}-${gpsTime.month.toString().padLeft(2, '0')}-${gpsTime.day.toString().padLeft(2, '0')} '
        '${gpsTime.hour.toString().padLeft(2, '0')}:${gpsTime.minute.toString().padLeft(2, '0')}:${gpsTime.second.toString().padLeft(2, '0')}';
    playbackAddress.value =
        idx < _routeAddresses.length ? _routeAddresses[idx] : _routeAddresses.last;
  }

  /// Duration in milliseconds between steps depending on the speed scale
  int get _playbackIntervalMs {
    switch (playbackSelectedSpeed.value) {
      case AppStrings.slow:
        return 2000;
      case AppStrings.normal:
        return 1000;
      case AppStrings.fastSpeed:
        return 500;
      case AppStrings.veryFast:
        return 250;
      default:
        return 1000;
    }
  }

  void togglePlayback() {
    if (playbackIsPlaying.value) {
      pausePlayback();
    } else {
      startPlayback();
    }
  }

  void startPlayback() {
    // If at the end, restart
    if (playbackCurrentIndex.value >= playbackRoute.length - 1) {
      playbackCurrentIndex.value = 0;
      _updatePlaybackMarkers();
      _updatePlaybackPolylines();
      _updatePlaybackInfo();
    }
    playbackIsPlaying.value = true;
    _startPlaybackTimer();
  }

  void pausePlayback() {
    playbackIsPlaying.value = false;
    _playbackTimer?.cancel();
    _playbackTimer = null;
  }

  void stopPlayback() {
    pausePlayback();
    playbackCurrentIndex.value = 0;
    _updatePlaybackMarkers();
    _updatePlaybackPolylines();
    _updatePlaybackInfo();
    _fitPlaybackRoute();
  }

  void _startPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(
      Duration(milliseconds: _playbackIntervalMs),
      (_) => _advancePlayback(),
    );
  }

  void _advancePlayback() {
    if (playbackCurrentIndex.value >= playbackRoute.length - 1) {
      // Reached the end
      pausePlayback();
      return;
    }

    playbackCurrentIndex.value++;
    _updatePlaybackMarkers();
    _updatePlaybackPolylines();
    _updatePlaybackInfo();

    // Track the vehicle on map
    final currentPos = playbackRoute[playbackCurrentIndex.value];
    playbackMapController?.animateCamera(
      CameraUpdate.newLatLng(currentPos),
    );
  }

  /// Called when speed selection changes (restart timer if currently playing)
  void onPlaybackSpeedChanged(String speed) {
    playbackSelectedSpeed.value = speed;
    if (playbackIsPlaying.value) {
      _startPlaybackTimer(); // Restart with new interval
    }
  }

  void _disposePlayback() {
    _playbackTimer?.cancel();
    _playbackTimer = null;
    playbackMapController?.dispose();
    playbackMapController = null;
  }

  @override
  void onClose() {
    _disposeLiveTrack();
    _disposePlayback();
    searchController.dispose();
    overSpeedController.dispose();
    immobilizePasswordController.dispose();
    super.onClose();
  }
}
