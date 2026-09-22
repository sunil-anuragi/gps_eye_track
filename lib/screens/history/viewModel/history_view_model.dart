import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/history/model/history_point.dart';
import 'package:gps_software/screens/history/widgets/history_filter_dialog.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:intl/intl.dart';

class HistoryViewModel extends BaseController {
  static const List<int> playbackSpeeds = [1, 2, 4, 8];
  static const Duration _baseTick = Duration(milliseconds: 400);

  late final Map<String, dynamic> vehicle;
  late final String vehicleNo;
  late final String vehicleType;

  GoogleMapController? mapController;

  final selectedPeriod = HistoryPeriod.oneHourAgo.obs;
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().obs;

  final points = <HistoryPoint>[].obs;
  final currentIndex = 0.obs;
  final isPlaying = false.obs;
  final speedIndex = 0.obs;
  final totalDistanceKm = 0.0.obs;
  final mapType = MapType.normal.obs;
  final markers = Rx<Set<Marker>>({});
  final polylines = Rx<Set<Polyline>>({});

  final DateFormat displayFormat = DateFormat('dd-MMM-yyyy hh:mm:ss a');

  Set<Marker> _staticMarkers = {};
  BitmapDescriptor? _carIcon;
  BitmapDescriptor? _startIcon;
  BitmapDescriptor? _endIcon;
  BitmapDescriptor? _parkingIcon;
  Timer? _playTimer;

  String get title => '$vehicleNo | ${capitalizeLabel(vehicleType)}';
  bool get hasData => points.isNotEmpty;
  int get playbackSpeed => playbackSpeeds[speedIndex.value];

  HistoryPoint? get currentPoint =>
      hasData ? points[currentIndex.value.clamp(0, points.length - 1)] : null;

  double get progress =>
      points.length > 1 ? currentIndex.value / (points.length - 1) : 0;

  @override
  void onInit() {
    super.onInit();
    vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'NL01AD8732';
    vehicleType = vehicle['vehicleType'] as String? ?? 'truck';
    _loadMarkerIcons();
  }

  @override
  void onReady() {
    super.onReady();
    openFilterDialog();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (hasData) _fitRoute();
  }

  // ---------------------------------------------------------------- filter

  void openFilterDialog() {
    pause();
    Get.dialog(
      HistoryFilterDialog(
        initialPeriod: selectedPeriod.value,
        initialFrom: fromDate.value,
        initialTo: toDate.value,
        onApply: (period, from, to) => applyFilter(period, from: from, to: to),
      ),
      barrierDismissible: true,
    );
  }

  /// Applies the period picked in the dialog and loads the route
  void applyFilter(HistoryPeriod period, {DateTime? from, DateTime? to}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    selectedPeriod.value = period;

    switch (period) {
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
    loadHistory();
  }

  // --------------------------------------------------------------- loading

  /// Loads the route between [fromDate] and [toDate].
  /// Swap [_mockRoute] for the history API response when it is available.
  Future<void> loadHistory() async {
    pause();
    final route = _mockRoute(fromDate.value, toDate.value);
    points.assignAll(route);
    currentIndex.value = 0;

    if (route.isEmpty) {
      totalDistanceKm.value = 0;
      markers.value = {};
      polylines.value = {};
      showSnack(msg: 'No history found for the selected period');
      return;
    }

    totalDistanceKm.value = _routeDistanceKm(route);
    polylines.value = {
      Polyline(
        polylineId: const PolylineId('history_route'),
        points: route.map((p) => p.position).toList(),
        color: const Color(0xff22e02a),
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
      ),
    };
    _buildStaticMarkers();
    _updateCarMarker();
    _fitRoute();
  }

  List<HistoryPoint> _mockRoute(DateTime from, DateTime to) {
    const waypoints = [
      LatLng(22.5985, 88.2830),
      LatLng(22.5942, 88.2705),
      LatLng(22.5908, 88.2565),
      LatLng(22.5902, 88.2440),
      LatLng(22.5868, 88.2332),
      LatLng(22.5795, 88.2245),
      LatLng(22.5738, 88.2160),
      LatLng(22.5692, 88.2025),
      LatLng(22.5655, 88.1885),
      LatLng(22.5622, 88.1790),
    ];

    final positions = <LatLng>[];
    for (var i = 0; i < waypoints.length - 1; i++) {
      final a = waypoints[i];
      final b = waypoints[i + 1];
      const steps = 20;
      for (var s = 0; s < steps; s++) {
        final t = s / steps;
        positions.add(LatLng(
          a.latitude + (b.latitude - a.latitude) * t,
          a.longitude + (b.longitude - a.longitude) * t,
        ));
      }
    }
    positions.add(waypoints.last);

    final span = to.difference(from).inSeconds;
    final last = positions.length - 1;
    return List.generate(positions.length, (i) {
      final isParking = i == 0 || i == last || i == last ~/ 2;
      return HistoryPoint(
        position: positions[i],
        time: from.add(Duration(seconds: (span * i / last).round())),
        speed: isParking ? 0 : 25 + 30 * math.sin(i / 7).abs(),
        isParking: isParking,
      );
    });
  }

  double _routeDistanceKm(List<HistoryPoint> route) {
    var total = 0.0;
    for (var i = 1; i < route.length; i++) {
      total += _distanceKm(route[i - 1].position, route[i].position);
    }
    return total;
  }

  double _distanceKm(LatLng a, LatLng b) {
    const earthRadius = 6371.0;
    final dLat = _rad(b.latitude - a.latitude);
    final dLng = _rad(b.longitude - a.longitude);
    final h = math.pow(math.sin(dLat / 2), 2) +
        math.cos(_rad(a.latitude)) *
            math.cos(_rad(b.latitude)) *
            math.pow(math.sin(dLng / 2), 2);
    return 2 * earthRadius * math.asin(math.sqrt(h));
  }

  double _bearing(LatLng a, LatLng b) {
    final lat1 = _rad(a.latitude);
    final lat2 = _rad(b.latitude);
    final dLng = _rad(b.longitude - a.longitude);
    final y = math.sin(dLng) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLng);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  double _rad(double deg) => deg * math.pi / 180;

  // --------------------------------------------------------------- markers

  Future<void> _loadMarkerIcons() async {
    const config = ImageConfiguration();
    _carIcon = await BitmapDescriptor.asset(config, Assets.mapMarkerCarRunning,
        width: 20, height: 40);
    _startIcon = await BitmapDescriptor.asset(config, Assets.playbackStartIcon,
        width: 64, height: 43);
    _endIcon = await BitmapDescriptor.asset(config, Assets.playbackEndIcon,
        width: 64, height: 43);
    _parkingIcon = await BitmapDescriptor.asset(
        config, Assets.playbackParkingIcon,
        width: 32, height: 32);
    if (hasData) {
      _buildStaticMarkers();
      _updateCarMarker();
    }
  }

  void _buildStaticMarkers() {
    final route = points;
    _staticMarkers = {
      Marker(
        markerId: const MarkerId('start'),
        position: route.first.position,
        icon: _startIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        anchor: const Offset(0.5, 1),
        zIndexInt: 1,
      ),
      Marker(
        markerId: const MarkerId('end'),
        position: route.last.position,
        icon: _endIcon ?? BitmapDescriptor.defaultMarker,
        anchor: const Offset(0.5, 1),
        zIndexInt: 1,
      ),
      for (var i = 0; i < route.length; i++)
        if (route[i].isParking)
          Marker(
            markerId: MarkerId('parking_$i'),
            position: route[i].position,
            icon: _parkingIcon ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
            anchor: const Offset(0.5, 1),
            zIndexInt: 2,
            infoWindow: InfoWindow(
              title: 'Parking',
              snippet: displayFormat.format(route[i].time),
            ),
          ),
    };
  }

  void _updateCarMarker() {
    final point = currentPoint;
    if (point == null) return;
    final i = currentIndex.value;
    final next = i < points.length - 1 ? points[i + 1] : null;
    final prev = i > 0 ? points[i - 1] : null;
    final rotation = next != null
        ? _bearing(point.position, next.position)
        : prev != null
            ? _bearing(prev.position, point.position)
            : 0.0;

    markers.value = {
      ..._staticMarkers,
      Marker(
        markerId: const MarkerId('vehicle'),
        position: point.position,
        icon: _carIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        rotation: rotation,
        anchor: const Offset(0.5, 0.5),
        flat: true,
        zIndexInt: 3,
      ),
    };
  }

  void _fitRoute() {
    if (!hasData || mapController == null) return;
    final lats = points.map((p) => p.position.latitude);
    final lngs = points.map((p) => p.position.longitude);
    final bounds = LatLngBounds(
      southwest: LatLng(lats.reduce(math.min), lngs.reduce(math.min)),
      northeast: LatLng(lats.reduce(math.max), lngs.reduce(math.max)),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
    });
  }

  // -------------------------------------------------------------- playback

  void togglePlay() {
    if (!hasData) {
      openFilterDialog();
      return;
    }
    isPlaying.value ? pause() : play();
  }

  void play() {
    if (currentIndex.value >= points.length - 1) currentIndex.value = 0;
    isPlaying.value = true;
    _restartTimer();
  }

  void pause() {
    _playTimer?.cancel();
    isPlaying.value = false;
  }

  void _restartTimer() {
    _playTimer?.cancel();
    _playTimer = Timer.periodic(
      _baseTick ~/ playbackSpeed,
      (_) => _step(),
    );
  }

  void _step() {
    if (currentIndex.value >= points.length - 1) {
      pause();
      return;
    }
    currentIndex.value++;
    _updateCarMarker();
    mapController?.animateCamera(
      CameraUpdate.newLatLng(currentPoint!.position),
    );
  }

  /// Cycles 1x → 2x → 4x → 8x
  void changeSpeed() {
    speedIndex.value = (speedIndex.value + 1) % playbackSpeeds.length;
    if (isPlaying.value) _restartTimer();
    showSnack(msg: 'Playback speed ${playbackSpeed}x');
  }

  /// Jumps playback to [fraction] (0..1) of the route
  void seekTo(double fraction) {
    if (!hasData) return;
    currentIndex.value =
        (fraction.clamp(0.0, 1.0) * (points.length - 1)).round();
    _updateCarMarker();
  }

  void changeMapType() {
    showMapTypeSheet(
      current: mapType.value,
      onSelected: (type) => mapType.value = type,
    );
  }

  @override
  void onClose() {
    _playTimer?.cancel();
    mapController?.dispose();
    super.onClose();
  }
}
