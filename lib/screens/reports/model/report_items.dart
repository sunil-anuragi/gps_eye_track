import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A position with its human readable address
class ReportLocation {
  const ReportLocation(this.position, this.address);

  final LatLng position;
  final String address;
}

/// Stop, idle and AC reports: something that started and ended at one place
class StopReportItem {
  const StopReportItem({
    required this.start,
    required this.end,
    required this.location,
  });

  final DateTime start;
  final DateTime end;
  final ReportLocation location;

  Duration get duration => end.difference(start);
}

/// Trip and overspeed reports: a drive from one place to another
class TripReportItem {
  const TripReportItem({
    required this.start,
    required this.end,
    required this.from,
    required this.to,
    required this.distanceKm,
    required this.avgSpeed,
    required this.maxSpeed,
    required this.startSpeed,
    required this.endSpeed,
    required this.route,
    this.parkings = const [],
  });

  final DateTime start;
  final DateTime end;
  final ReportLocation from;
  final ReportLocation to;
  final double distanceKm;
  final double avgSpeed;
  final double maxSpeed;
  final double startSpeed;
  final double endSpeed;
  final List<LatLng> route;
  final List<LatLng> parkings;

  Duration get duration => end.difference(start);
}

/// Distance travelled on one day
class DistanceReportItem {
  const DistanceReportItem({
    required this.date,
    required this.from,
    required this.to,
    required this.distanceKm,
  });

  final DateTime date;
  final ReportLocation from;
  final ReportLocation to;
  final double distanceKm;
}

/// Movement between two points
class MovementReportItem {
  const MovementReportItem({
    required this.start,
    required this.end,
    required this.from,
    required this.to,
    required this.distanceKm,
  });

  final DateTime start;
  final DateTime end;
  final ReportLocation from;
  final ReportLocation to;
  final double distanceKm;
}

/// Distance covered in a time window
class DurationReportItem {
  const DurationReportItem({
    required this.start,
    required this.end,
    required this.distanceKm,
  });

  final DateTime start;
  final DateTime end;
  final double distanceKm;
}

/// Geofence enter / exit event
class GeofenceReportItem {
  const GeofenceReportItem({
    required this.vehicleNo,
    required this.fenceName,
    required this.isEnter,
    required this.time,
    required this.location,
  });

  final String vehicleNo;
  final String fenceName;
  final bool isEnter;
  final DateTime time;
  final ReportLocation location;
}

/// Temperature sensor reading
class TempReportItem {
  const TempReportItem({
    required this.time,
    required this.temperature,
    required this.location,
  });

  final DateTime time;
  final double temperature;
  final ReportLocation location;
}
