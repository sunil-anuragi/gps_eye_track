import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/generated/assets.dart';

enum MapVehicleMarkerStatus { stop, running, offline }

MapVehicleMarkerStatus mapVehicleMarkerStatusFromLabel(String status) {
  final lower = status.toLowerCase();
  if (lower.contains('offline')) return MapVehicleMarkerStatus.offline;
  if (lower.contains('stop') || lower.contains('park') || lower.contains('idle')) {
    return MapVehicleMarkerStatus.stop;
  }
  if (lower.contains('running') || lower.contains('moving')) {
    return MapVehicleMarkerStatus.running;
  }
  return MapVehicleMarkerStatus.running;
}

class MapVehicleMarker {
  final String id;
  final double latitude;
  final double longitude;
  final MapVehicleMarkerStatus status;
  final String address;
  /// Clockwise degrees from north. Icon asset points up (north) at 0°.
  final double rotation;

  const MapVehicleMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.address,
    this.rotation = 0,
  });
}

class MapVehicleMarkerIcon {
  MapVehicleMarkerIcon._();

  static const int iconWidth = 50;
  static const int iconHeight = 100;
  static const Offset anchor = Offset(0.5, 0.5);

  static final Map<MapVehicleMarkerStatus, BitmapDescriptor> _icons = {};
  static bool _loaded = false;

  static String assetFor(MapVehicleMarkerStatus status) {
    switch (status) {
      case MapVehicleMarkerStatus.stop:
        return Assets.mapMarkerCarStop;
      case MapVehicleMarkerStatus.running:
        return Assets.mapMarkerCarRunning;
      case MapVehicleMarkerStatus.offline:
        return Assets.mapMarkerCarOffline;
    }
  }

  static Future<void> load() async {
    if (_loaded) return;

    for (final status in MapVehicleMarkerStatus.values) {
      _icons[status] = await _bitmapFromAsset(assetFor(status));
    }
    _loaded = true;
  }

  static Future<BitmapDescriptor> _bitmapFromAsset(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: iconWidth,
      targetHeight: iconHeight,
    );
    final frame = await codec.getNextFrame();
    final byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  static BitmapDescriptor iconFor(MapVehicleMarkerStatus status) {
    return _icons[status]!;
  }

  static bool get isLoaded => _loaded;

  static Marker toMarker(
    MapVehicleMarker vehicle, {
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(vehicle.id),
      position: LatLng(vehicle.latitude, vehicle.longitude),
      icon: iconFor(vehicle.status),
      anchor: anchor,
      rotation: vehicle.rotation,
      flat: true,
      zIndexInt: 2,
      infoWindow: InfoWindow(title: vehicle.id),
      onTap: onTap,
    );
  }

  static Set<Marker> toMarkers(
    List<MapVehicleMarker> vehicles, {
    void Function(MapVehicleMarker vehicle)? onTap,
  }) {
    return vehicles
        .map(
          (vehicle) => toMarker(
            vehicle,
            onTap: onTap == null ? null : () => onTap(vehicle),
          ),
        )
        .toSet();
  }
}
