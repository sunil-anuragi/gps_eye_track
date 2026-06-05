import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/enum/map_type.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:gps_software/util/user_details.dart';

class MapVehicleMarker {
  final String id;
  final double latitude;
  final double longitude;
  final double hue;
  final String address;

  const MapVehicleMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.hue,
    required this.address,
  });
}

class MapViewModel extends BaseController {
  static const LatLng defaultLocation = LatLng(28.7024, 77.2695);
  static const double defaultZoom = 14;

  GoogleMapController? mapController;
  Timer? _refreshTimer;

  RxInt refreshSeconds = 10.obs;
  Rx<MapType> mapType = MapType.normal.obs;
  Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  RxString selectedAddress =
      'C6/233 Bhagwan Shree Pashuram Rd, Block C, Yamuna Vihar, Shahdara, New Delhi, Delhi 110053, India'
          .obs;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: defaultLocation,
    zoom: defaultZoom,
  );

  final List<MapVehicleMarker> vehicleMarkers = const [
    MapVehicleMarker(
      id: 'DL2RQ-3478',
      latitude: 28.7041,
      longitude: 77.2650,
      hue: BitmapDescriptor.hueGreen,
      address:
          'C6/233 Bhagwan Shree Pashuram Rd, Block C, Yamuna Vihar, Shahdara, New Delhi, Delhi 110053, India',
    ),
    MapVehicleMarker(
      id: 'DL6RQ-7562',
      latitude: 28.6995,
      longitude: 77.2720,
      hue: BitmapDescriptor.hueAzure,
      address: 'Yamuna Vihar, Shahdara, New Delhi, Delhi 110053, India',
    ),
    MapVehicleMarker(
      id: 'DL2RAA2389',
      latitude: 28.7060,
      longitude: 77.2680,
      hue: BitmapDescriptor.hueRed,
      address: 'Bhajanpura, Shahdara, New Delhi, Delhi 110053, India',
    ),
    MapVehicleMarker(
      id: 'ACUTE140',
      latitude: 28.7005,
      longitude: 77.2640,
      hue: BitmapDescriptor.hueOrange,
      address: 'Maujpur, Shahdara, New Delhi, Delhi 110053, India',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadMapType();
    _buildMarkers();
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

  void _buildMarkers() {
    markers.value = vehicleMarkers
        .map(
          (vehicle) => Marker(
            markerId: MarkerId(vehicle.id),
            position: LatLng(vehicle.latitude, vehicle.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(vehicle.hue),
            infoWindow: InfoWindow(title: vehicle.id),
            onTap: () => selectedAddress.value = vehicle.address,
          ),
        )
        .toSet();
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

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
