import 'package:flutter/material.dart';
import 'package:gps_software/generated/assets.dart';

enum ReportType {
  distance(
      'DISTANCE REPORTS', 'DISTANCE REPORTS', Icons.route, Color(0xfff26d5b)),
  stop('STOP REPORTS', 'STOP REPORTS', Icons.no_crash, Color(0xff3f7fd6)),
  idle('IDLE REPORTS', 'IDLE REPORTS', Icons.local_taxi, Color(0xfff5a623)),
  trip('TRIP REPORTS', 'TRIP REPORTS', Icons.luggage, Color(0xffe8505b)),
  ac('AC REPORTS', 'AC REPORTS', Icons.ac_unit, Color(0xff3a4b5c)),
  temp('TEMP REPORTS', 'TEMP REPORTS', Icons.thermostat, Color(0xffb5835a)),
  overspeed(
      'OVERSPEED REPORTS', 'OVERSPEED REPORTS', Icons.speed, Color(0xffe53935)),
  geofence('GEOFENCE REPORTS', 'GEOFENCE REPORTS', Icons.travel_explore,
      Color(0xff1e88e5)),
  movement('MOVEMENT REPORT', 'MOVEMENT REPORTS', Icons.directions_car,
      Color(0xfff2c230)),
  durationSummary('DURATION SUMMARY', 'DURATION REPORTS', Icons.more_time,
      Color(0xffc62828));

  const ReportType(this.tileTitle, this.screenTitle, this.icon, this.color);

  /// Label on the All Reports grid
  final String tileTitle;

  /// Title in the report screen's app bar
  final String screenTitle;
  final IconData icon;
  final Color color;

  /// Illustration shown on the All Reports tile
  String get tileImage => switch (this) {
        ReportType.distance => Assets.reportTileDistance,
        ReportType.stop => Assets.reportTileStop,
        ReportType.idle => Assets.reportTileIdle,
        ReportType.trip => Assets.reportTileTrip,
        ReportType.ac => Assets.reportTileAc,
        ReportType.temp => Assets.reportTileTemp,
        ReportType.overspeed => Assets.reportTileOverspeed,
        ReportType.geofence => Assets.reportTileGeofence,
        ReportType.movement => Assets.reportTileMovement,
        ReportType.durationSummary => Assets.reportTileDuration,
      };

  /// Route of this report's screen
  String get route => '/${name}Report';
}
