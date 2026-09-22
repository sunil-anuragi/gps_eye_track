import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveTrackingViewModel extends BaseController {
  /// Seconds between two location refreshes (shown in the top-left bubble)
  static const int refreshInterval = 10;
  static const LatLng _defaultPosition = LatLng(22.5725, 88.2280);

  late final Map<String, dynamic> vehicle;
  late final String vehicleNo;
  late final String vehicleType;

  GoogleMapController? mapController;

  final vehiclePosition = _defaultPosition.obs;
  final startPosition = _defaultPosition.obs;
  final speed = '0.0 km/h'.obs;
  final status = 'Stopped'.obs;
  final duration = ''.obs;
  final lastUpdate = ''.obs;
  final address = 'Fetching address...'.obs;

  final mapType = MapType.normal.obs;
  final isTrafficEnabled = false.obs;
  final isLocked = true.obs;
  final countdown = refreshInterval.obs;
  final markers = Rx<Set<Marker>>({});

  BitmapDescriptor? _vehicleIcon;
  BitmapDescriptor? _startIcon;
  Timer? _timer;

  bool get isRunning => status.value.toLowerCase().contains('run');

  String get title => '$vehicleNo | ${capitalizeLabel(vehicleType)}';

  @override
  void onInit() {
    super.onInit();
    vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'NL01AD8732';
    vehicleType = vehicle['vehicleType'] as String? ?? 'truck';
    speed.value = vehicle['speed'] as String? ?? '0.0 km/h';
    lastUpdate.value =
        vehicle['lastUpdate'] as String? ?? '12-May-2026 01:11:24 pm';
    address.value = vehicle['address'] as String? ??
        '14 m from Lach Gobal Logistic Pvt Ltd - Sankrail, West Bengal';
    _parseStatus(vehicle['status'] as String? ?? 'Stopped (24 Min, 18 Sec)');

    final position = parseVehicleLatLng(vehicle, _defaultPosition);
    vehiclePosition.value = position;
    startPosition.value = position;

    _loadMarkerIcons();
    _startTimer();
  }

  void _parseStatus(String raw) {
    final open = raw.indexOf('(');
    final close = raw.indexOf(')');
    if (open != -1 && close > open) {
      status.value = raw.substring(0, open).trim();
      duration.value = raw.substring(open + 1, close).trim();
    } else {
      status.value = raw.trim();
      duration.value = '';
    }
  }

  Future<void> _loadMarkerIcons() async {
    const config = ImageConfiguration();
    _vehicleIcon = await BitmapDescriptor.asset(
      config,
      Assets.mapMarkerCarRunning,
      width: 22,
      height: 44,
    );
    _startIcon = await BitmapDescriptor.asset(
      config,
      Assets.playbackStartIcon,
      width: 64,
      height: 43,
    );
    _updateMarkers();
  }

  void _updateMarkers() {
    markers.value = {
      Marker(
        markerId: const MarkerId('start'),
        position: startPosition.value,
        icon: _startIcon ?? BitmapDescriptor.defaultMarker,
        anchor: const Offset(0.5, 1),
        zIndexInt: 1,
      ),
      Marker(
        markerId: MarkerId(vehicleNo),
        position: vehiclePosition.value,
        icon: _vehicleIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        anchor: const Offset(0.5, 0.5),
        flat: true,
        zIndexInt: 2,
        infoWindow: InfoWindow(title: vehicleNo, snippet: status.value),
      ),
    };
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (countdown.value <= 1) {
        countdown.value = refreshInterval;
        refreshLocation();
      } else {
        countdown.value--;
      }
    });
  }

  /// Pulls the latest vehicle position.
  /// Hook the live-location API in here; it currently re-uses the last fix.
  Future<void> refreshLocation() async {
    _updateMarkers();
    if (isLocked.value) _moveCamera(vehiclePosition.value);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _moveCamera(LatLng target) {
    mapController?.animateCamera(CameraUpdate.newLatLng(target));
  }

  void toggleTraffic() => isTrafficEnabled.toggle();

  void changeMapType() {
    showMapTypeSheet(
      current: mapType.value,
      onSelected: (type) => mapType.value = type,
    );
  }

  void toggleLock() {
    isLocked.toggle();
    if (isLocked.value) _moveCamera(vehiclePosition.value);
    showSnack(
        msg: isLocked.value
            ? 'Map locked on vehicle'
            : 'Map unlocked, move freely');
  }

  void recenter() {
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(vehiclePosition.value, 16),
    );
  }

  String get _mapsUrl =>
      'https://www.google.com/maps/search/?api=1&query=${vehiclePosition.value.latitude},${vehiclePosition.value.longitude}';

  Future<void> shareLocation() async {
    await Share.share(
      '$title\n${status.value} - ${speed.value}\n${address.value}\n$_mapsUrl',
    );
  }

  Future<void> openInGoogleMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${vehiclePosition.value.latitude},${vehiclePosition.value.longitude}',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      showSnack(msg: 'Unable to open Google Maps');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    mapController?.dispose();
    super.onClose();
  }
}
