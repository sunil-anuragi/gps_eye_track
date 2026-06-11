import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/enum/map_type.dart';
import 'package:gps_software/commonWidget/vehicle_map_tooltip.dart';
import 'package:gps_software/screens/bottomBar/module/map/data/map_dummy_data.dart';
import 'package:gps_software/screens/bottomBar/module/map/helper/map_vehicle_marker_icon.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:gps_software/util/user_details.dart';

class MapViewModel extends BaseController {
  static const LatLng defaultLocation = LatLng(28.7024, 77.2695);
  static const double defaultZoom = 14;

  GoogleMapController? mapController;
  Timer? _refreshTimer;

  RxInt refreshSeconds = 10.obs;
  Rx<MapType> mapType = MapType.normal.obs;
  final markers = <Marker>{}.obs;
  RxString selectedAddress = MapDummyData.defaultAddress.obs;
  RxBool showVehicleTooltip = false.obs;
  Rxn<VehicleMapTooltipData> selectedVehicleTooltip = Rxn<VehicleMapTooltipData>();

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: defaultLocation,
    zoom: defaultZoom,
  );

  List<MapVehicleMarker> get vehicleMarkers => MapDummyData.vehicles;

  @override
  void onInit() {
    super.onInit();
    _loadMapType();
    _loadVehicleMarkers();
    _startRefreshTimer();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    mapController?.dispose();
    super.onClose();
  }

  Future<void> _loadMapType() async {
    final savedType = await UserDetails().getMapType;
    mapType.value = _mapTypeFromEnum(savedType);
  }

  MapType _mapTypeFromEnum(String type) {
    switch (MapTypeEnum.values.byName(type)) {
      case MapTypeEnum.Satellite:
        return MapType.satellite;
      case MapTypeEnum.Terrain:
        return MapType.terrain;
      case MapTypeEnum.Hybrid:
        return MapType.hybrid;
      case MapTypeEnum.Normal:
        return MapType.normal;
    }
  }

  Future<void> _loadVehicleMarkers() async {
    await MapVehicleMarkerIcon.load();
    _buildMarkers();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (MapVehicleMarkerIcon.isLoaded) {
      _buildMarkers();
    }
  }

  void _buildMarkers() {
    if (!MapVehicleMarkerIcon.isLoaded) return;

    final updatedMarkers = MapVehicleMarkerIcon.toMarkers(
      vehicleMarkers,
      onTap: onVehicleMarkerTap,
    );
    markers
      ..clear()
      ..addAll(updatedMarkers);
  }

  void _startRefreshTimer() {
    _refreshTimer?.cancel();
    refreshSeconds.value = 10;
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (refreshSeconds.value <= 1) {
        onRefresh();
      } else {
        refreshSeconds.value--;
      }
    });
  }

  void onVehicleMarkerTap(MapVehicleMarker vehicle) {
    selectedAddress.value = vehicle.address;
    selectedVehicleTooltip.value = vehicle.tooltip;
    showVehicleTooltip.value = true;
  }

  void onMapTap(LatLng position) {
    showVehicleTooltip.value = false;
  }

  void onCameraMove(CameraPosition position) {}

  Future<void> zoomIn() async {
    final zoom = await mapController?.getZoomLevel() ?? defaultZoom;
    await mapController?.animateCamera(CameraUpdate.zoomTo(zoom + 1));
  }

  Future<void> zoomOut() async {
    final zoom = await mapController?.getZoomLevel() ?? defaultZoom;
    await mapController?.animateCamera(CameraUpdate.zoomTo(zoom - 1));
  }

  Future<void> goToDefaultLocation() async {
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(initialCameraPosition),
    );
  }

  void toggleMapType() {
    const types = [
      MapType.normal,
      MapType.satellite,
      MapType.terrain,
      MapType.hybrid,
    ];
    final currentIndex = types.indexOf(mapType.value);
    final nextIndex = (currentIndex + 1) % types.length;
    mapType.value = types[nextIndex];
  }

  void onRefresh() {
    refreshSeconds.value = 10;
    goToDefaultLocation();
    _buildMarkers();
  }
}
