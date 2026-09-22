import 'package:google_maps_flutter/google_maps_flutter.dart';

enum HistoryPeriod { oneHourAgo, today, yesterday, userDefined }

extension HistoryPeriodLabel on HistoryPeriod {
  String get label => switch (this) {
        HistoryPeriod.oneHourAgo => '1 hr ago',
        HistoryPeriod.today => 'Today',
        HistoryPeriod.yesterday => 'Yesterday',
        HistoryPeriod.userDefined => 'User-defined',
      };
}

/// One recorded position of the vehicle on the history route
class HistoryPoint {
  const HistoryPoint({
    required this.position,
    required this.time,
    required this.speed,
    this.isParking = false,
  });

  final LatLng position;
  final DateTime time;

  /// km/h
  final double speed;
  final bool isParking;
}
