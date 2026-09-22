import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum AlertType {
  overSpeed('Over Speed', Icons.speed),
  ignitionOn('Ignition On', Icons.key),
  ignitionOff('Ignition Off', Icons.key_off),
  geofenceIn('Geofence In', Icons.share_location),
  geofenceOut('Geofence Out', Icons.wrong_location),
  powerCut('Power Cut', Icons.power_off);

  const AlertType(this.label, this.icon);

  final String label;
  final IconData icon;
}

class VehicleAlert {
  const VehicleAlert({
    required this.vehicleNo,
    required this.type,
    required this.time,
    required this.position,
    required this.address,
    this.speed,
  });

  final String vehicleNo;
  final AlertType type;
  final DateTime time;
  final LatLng position;
  final String address;

  /// km/h, for over-speed alerts
  final double? speed;

  /// "Over Speed (speed:23 Km/h)"
  String get description => speed != null
      ? '${type.label} (speed:${speed!.toStringAsFixed(0)} Km/h)'
      : type.label;
}
