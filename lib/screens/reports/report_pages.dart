import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/reports/bindings/report_binding.dart';
import 'package:gps_software/screens/reports/model/report_type.dart';
import 'package:gps_software/screens/reports/view/ac_report/ac_report_view.dart';
import 'package:gps_software/screens/reports/view/distance_report/distance_report_view.dart';
import 'package:gps_software/screens/reports/view/duration_report/duration_report_view.dart';
import 'package:gps_software/screens/reports/view/geofence_report/geofence_report_view.dart';
import 'package:gps_software/screens/reports/view/idle_report/idle_report_view.dart';
import 'package:gps_software/screens/reports/view/movement_report/movement_report_view.dart';
import 'package:gps_software/screens/reports/view/overspeed_report/overspeed_report_view.dart';
import 'package:gps_software/screens/reports/view/stop_report/stop_report_map_view.dart';
import 'package:gps_software/screens/reports/view/stop_report/stop_report_view.dart';
import 'package:gps_software/screens/reports/view/temp_report/temp_report_view.dart';
import 'package:gps_software/screens/reports/view/trip_report/trip_report_map_view.dart';
import 'package:gps_software/screens/reports/view/trip_report/trip_report_view.dart';

/// Routes of every report screen
class ReportPages {
  static Widget _viewFor(ReportType type) => switch (type) {
        ReportType.distance => const DistanceReportView(),
        ReportType.stop => const StopReportView(),
        ReportType.idle => const IdleReportView(),
        ReportType.trip => const TripReportView(),
        ReportType.ac => const AcReportView(),
        ReportType.temp => const TempReportView(),
        ReportType.overspeed => const OverspeedReportView(),
        ReportType.geofence => const GeofenceReportView(),
        ReportType.movement => const MovementReportView(),
        ReportType.durationSummary => const DurationReportView(),
      };

  static List<GetPage> routes({Transition? transition}) => [
        for (final type in ReportType.values)
          GetPage(
            name: type.route,
            page: () => _viewFor(type),
            binding: ReportBinding(),
            transition: transition,
          ),
        // Map screens use the ReportViewModel of the report below them
        GetPage(
          name: StopReportMapView.stopReportMapView,
          page: () => const StopReportMapView(),
          transition: transition,
        ),
        GetPage(
          name: TripReportMapView.tripReportMapView,
          page: () => const TripReportMapView(),
          transition: transition,
        ),
      ];
}
