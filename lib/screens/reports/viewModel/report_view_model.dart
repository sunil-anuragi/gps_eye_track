import 'dart:io';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/history/model/history_point.dart';
import 'package:gps_software/screens/history/widgets/history_filter_dialog.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/model/report_type.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Shared state for every report screen: selected period, loading and data.
class ReportViewModel extends BaseController {
  late final ReportType reportType;
  late final Map<String, dynamic> vehicle;
  late final String vehicleNo;
  late final String vehicleType;

  final period = HistoryPeriod.today.obs;
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().obs;
  final isLoading = false.obs;

  /// True once a period has been chosen at least once
  final hasLoaded = false.obs;

  /// Report entries; the concrete type depends on [reportType]
  final items = <Object>[].obs;

  static final DateFormat dayFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat isoDayFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat timeFormat = DateFormat('hh:mm a');
  static final DateFormat fullFormat = DateFormat('dd-MMM-yyyy hh:mm:ss a');

  String get vehicleTitle => '$vehicleNo | ${vehicleType.toUpperCase()}';

  List<T> itemsOf<T>() => items.whereType<T>().toList();

  double get totalDistanceKm {
    var total = 0.0;
    for (final item in items) {
      if (item is DistanceReportItem) total += item.distanceKm;
      if (item is MovementReportItem) total += item.distanceKm;
      if (item is TripReportItem) total += item.distanceKm;
      if (item is DurationReportItem) total += item.distanceKm;
    }
    return total;
  }

  @override
  void onInit() {
    super.onInit();
    final args = (Get.arguments as Map<String, dynamic>?) ?? {};
    reportType = args['reportType'] as ReportType? ?? ReportType.stop;
    vehicle = (args['vehicle'] as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'DL23RW8855';
    vehicleType = vehicle['vehicleType'] as String? ?? 'car';
  }

  @override
  void onReady() {
    super.onReady();
    openDateDialog();
  }

  void openDateDialog() {
    Get.dialog(
      HistoryFilterDialog(
        title: 'Date',
        initialPeriod: period.value,
        initialFrom: fromDate.value,
        initialTo: toDate.value,
        onApply: (p, from, to) => applyPeriod(p, from: from, to: to),
      ),
    );
  }

  void applyPeriod(HistoryPeriod value, {DateTime? from, DateTime? to}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    period.value = value;
    switch (value) {
      case HistoryPeriod.oneHourAgo:
        fromDate.value = now.subtract(const Duration(hours: 1));
        toDate.value = now;
      case HistoryPeriod.today:
        fromDate.value = today;
        toDate.value = now;
      case HistoryPeriod.yesterday:
        fromDate.value = today.subtract(const Duration(days: 1));
        toDate.value = today.subtract(const Duration(seconds: 1));
      case HistoryPeriod.userDefined:
        fromDate.value = from ?? today;
        toDate.value = to ?? now;
    }
    loadReport();
  }

  /// Loads the report for the selected period.
  /// Replace [_mockItems] with the report API call.
  Future<void> loadReport() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    items.assignAll(_mockItems());
    hasLoaded.value = true;
    isLoading.value = false;
  }

  // -------------------------------------------------------------- export

  /// Exports the loaded report as CSV and opens the share sheet
  Future<void> downloadReport() async {
    if (items.isEmpty) {
      showSnack(msg: 'No data to download');
      return;
    }
    final rows = <List<String>>[_csvHeader(), ...items.map(_csvRow)];
    final csv = rows
        .map((r) => r.map((c) => '"${c.replaceAll('"', '""')}"').join(','))
        .join('\n');
    final dir = await getTemporaryDirectory();
    final name =
        '${reportType.name}_report_${vehicleNo}_${isoDayFormat.format(fromDate.value)}.csv';
    final file = File('${dir.path}/$name');
    await file.writeAsString(csv);
    await Share.shareXFiles([XFile(file.path)],
        subject: '${reportType.screenTitle} - $vehicleNo');
  }

  List<String> _csvHeader() => switch (reportType) {
        ReportType.distance || ReportType.ac => [
            'Date',
            'From',
            'To',
            'Distance (KM)'
          ],
        ReportType.stop || ReportType.idle => [
            'Start Time',
            'End Time',
            'Duration',
            'Address'
          ],
        ReportType.trip || ReportType.overspeed => [
            'Start Time',
            'End Time',
            'From',
            'To',
            'Distance (KM)',
            'Avg Speed',
            'Max Speed',
          ],
        ReportType.geofence => [
            'Vehicle',
            'Geofence',
            'Event',
            'Time',
            'Address'
          ],
        ReportType.movement => [
            'Start Time',
            'End Time',
            'From',
            'To',
            'Distance (KM)'
          ],
        ReportType.durationSummary => [
            'Start Time',
            'End Time',
            'Distance (KM)'
          ],
        ReportType.temp => [
            'Time',
            'Ignition',
            'Temperature (°C)',
            'Speed',
            'Address'
          ],
      };

  List<String> _csvRow(Object item) => switch (item) {
        DistanceReportItem i => [
            isoDayFormat.format(i.date),
            i.from.address,
            i.to.address,
            i.distanceKm.toStringAsFixed(2),
          ],
        AcReportItem i => [
            isoDayFormat.format(i.date),
            i.from.address,
            i.to.address,
            i.distanceKm.toStringAsFixed(2),
          ],
        StopReportItem i => [
            fullFormat.format(i.start),
            fullFormat.format(i.end),
            formatDuration(i.duration),
            i.location.address,
          ],
        TripReportItem i => [
            fullFormat.format(i.start),
            fullFormat.format(i.end),
            i.from.address,
            i.to.address,
            i.distanceKm.toStringAsFixed(2),
            i.avgSpeed.toStringAsFixed(1),
            i.maxSpeed.toStringAsFixed(1),
          ],
        GeofenceReportItem i => [
            i.vehicleNo,
            i.fenceName,
            i.isEnter ? 'Enter' : 'Exit',
            fullFormat.format(i.time),
            i.location.address,
          ],
        MovementReportItem i => [
            fullFormat.format(i.start),
            fullFormat.format(i.end),
            i.from.address,
            i.to.address,
            i.distanceKm.toStringAsFixed(2),
          ],
        DurationReportItem i => [
            fullFormat.format(i.start),
            fullFormat.format(i.end),
            i.distanceKm.toStringAsFixed(2),
          ],
        TempReportItem i => [
            fullFormat.format(i.time),
            i.ignitionOn ? 'On' : 'Off',
            i.temperature.toStringAsFixed(1),
            i.speed.toStringAsFixed(1),
            i.location.address,
          ],
        _ => const [],
      };

  static String formatDuration(Duration d) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}';
  }

  // ------------------------------------------------------------ mock data

  static const _addresses = [
    'Sheoghanj Sumerpur Bypass Rd, sthan 06902 Manjialpur police station, Makarpura',
    'NH16, Bankra, Howrah, West Bengal 711403',
    'Andul Road, Alampur, Howrah, West Bengal 711302',
    'Dhulagarh Industrial Park, Sankrail, West Bengal 711302',
    'Kona Expressway, Salap, Howrah, West Bengal 711403',
  ];

  List<Object> _mockItems() {
    final from = fromDate.value;
    final to = toDate.value;
    final span = to.difference(from);
    final count = span.inHours < 2 ? 3 : math.min(10, span.inHours ~/ 2 + 3);
    final step = Duration(seconds: math.max(60, span.inSeconds ~/ (count + 1)));
    final random = math.Random(from.day * 31 + reportType.index);

    ReportLocation place() {
      final position = LatLng(
        22.555 + random.nextDouble() * 0.045,
        88.175 + random.nextDouble() * 0.105,
      );
      return ReportLocation(
          position, _addresses[random.nextInt(_addresses.length)]);
    }

    DateTime at(int i) => from.add(step * i);
    Duration shortSpan() =>
        Duration(minutes: 5 + random.nextInt(math.max(6, step.inMinutes - 5)));

    switch (reportType) {
      case ReportType.distance:
        final days = math.max(1, (span.inHours / 24).ceil());
        return List.generate(days, (i) {
          return DistanceReportItem(
            date: DateTime(from.year, from.month, from.day + i),
            from: place(),
            to: place(),
            distanceKm: 40 + random.nextDouble() * 90,
          );
        });

      case ReportType.ac:
        return List.generate(count, (i) {
          return AcReportItem(
            date: at(i),
            from: place(),
            to: place(),
            distanceKm: 40 + random.nextDouble() * 90,
          );
        });

      case ReportType.stop:
      case ReportType.idle:
        return List.generate(count, (i) {
          final start = at(i);
          return StopReportItem(
            start: start,
            end: start.add(shortSpan()),
            location: place(),
          );
        });

      case ReportType.trip:
      case ReportType.overspeed:
        return List.generate(count, (i) {
          final start = at(i);
          final a = place();
          final b = place();
          final hasParking = reportType == ReportType.trip && i.isEven;
          final mid = LatLng(
            (a.position.latitude + b.position.latitude) / 2 + 0.006,
            (a.position.longitude + b.position.longitude) / 2 + 0.008,
          );
          final route = _interpolate(hasParking
              ? [a.position, mid, b.position]
              : [a.position, b.position]);
          final distance = _routeDistanceKm(route);
          final maxSpeed = reportType == ReportType.overspeed
              ? 61 + random.nextDouble() * 40
              : 40 + random.nextDouble() * 40;
          return TripReportItem(
            start: start,
            end: start.add(shortSpan()),
            from: a,
            to: b,
            distanceKm: distance,
            avgSpeed: maxSpeed * 0.6,
            maxSpeed: maxSpeed,
            startSpeed: 60 + random.nextDouble() * 5,
            endSpeed: 60 + random.nextDouble() * 10,
            route: route,
            parkings: hasParking ? [mid] : const [],
          );
        });

      case ReportType.geofence:
        const fences = ['Warehouse', 'Sankrail Depot', 'Howrah Hub'];
        return List.generate(count, (i) {
          return GeofenceReportItem(
            vehicleNo: vehicleNo,
            fenceName: fences[i % fences.length],
            isEnter: i.isEven,
            time: at(i),
            location: place(),
          );
        });

      case ReportType.movement:
        return List.generate(count, (i) {
          final start = at(i);
          return MovementReportItem(
            start: start,
            end: start.add(shortSpan()),
            from: place(),
            to: place(),
            distanceKm: random.nextDouble() * 12,
          );
        });

      case ReportType.durationSummary:
        return [
          DurationReportItem(
            start: from,
            end: to,
            distanceKm:
                20 + span.inMinutes / 60 * (8 + random.nextDouble() * 4),
          ),
        ];

      case ReportType.temp:
        return List.generate(count, (i) {
          final ignitionOn = i % 4 != 3;
          return TempReportItem(
            time: at(i),
            temperature: 18 + random.nextDouble() * 12,
            location: place(),
            ignitionOn: ignitionOn,
            speed: ignitionOn ? 20 + random.nextDouble() * 50 : 0,
          );
        });
    }
  }

  List<LatLng> _interpolate(List<LatLng> waypoints) {
    const steps = 25;
    final result = <LatLng>[];
    for (var i = 0; i < waypoints.length - 1; i++) {
      final a = waypoints[i];
      final b = waypoints[i + 1];
      for (var s = 0; s < steps; s++) {
        final t = s / steps;
        result.add(LatLng(
          a.latitude + (b.latitude - a.latitude) * t,
          a.longitude + (b.longitude - a.longitude) * t,
        ));
      }
    }
    result.add(waypoints.last);
    return result;
  }

  static double _routeDistanceKm(List<LatLng> route) {
    var total = 0.0;
    for (var i = 1; i < route.length; i++) {
      total += distanceKm(route[i - 1], route[i]);
    }
    return total;
  }

  static double distanceKm(LatLng a, LatLng b) {
    double rad(double d) => d * math.pi / 180;
    final dLat = rad(b.latitude - a.latitude);
    final dLng = rad(b.longitude - a.longitude);
    final h = math.pow(math.sin(dLat / 2), 2) +
        math.cos(rad(a.latitude)) *
            math.cos(rad(b.latitude)) *
            math.pow(math.sin(dLng / 2), 2);
    return 2 * 6371 * math.asin(math.sqrt(h));
  }
}
