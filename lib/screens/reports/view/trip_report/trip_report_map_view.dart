import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/model/report_type.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/view/trip_report/widgets/trip_report_card.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Route of one trip / overspeed entry with a playback bar.
/// Argument: `item` (TripReportItem).
class TripReportMapView extends StatefulWidget {
  static const tripReportMapView = '/tripReportMapView';

  const TripReportMapView({super.key});

  @override
  State<TripReportMapView> createState() => _TripReportMapViewState();
}

class _TripReportMapViewState extends State<TripReportMapView> {
  static const List<int> _speeds = [1, 2, 4, 8];

  final ReportViewModel controller = Get.find<ReportViewModel>();
  late final TripReportItem _item;
  late final bool _isOverspeed;

  GoogleMapController? _map;
  Timer? _timer;
  int _index = 0;
  int _speedIndex = 0;
  bool _playing = false;

  BitmapDescriptor? _carIcon;
  BitmapDescriptor? _startIcon;
  BitmapDescriptor? _endIcon;
  BitmapDescriptor? _parkingIcon;

  List<LatLng> get _route => _item.route;
  double get _progress => _route.length > 1 ? _index / (_route.length - 1) : 0;

  @override
  void initState() {
    super.initState();
    _item = (Get.arguments as Map<String, dynamic>)['item'] as TripReportItem;
    _isOverspeed = controller.reportType == ReportType.overspeed;
    _loadIcons();
  }

  Future<void> _loadIcons() async {
    const config = ImageConfiguration();
    final icons = await Future.wait([
      BitmapDescriptor.asset(config, Assets.mapMarkerCarRunning,
          width: 20, height: 40),
      BitmapDescriptor.asset(config, Assets.playbackStartIcon,
          width: 64, height: 43),
      BitmapDescriptor.asset(config, Assets.playbackEndIcon,
          width: 64, height: 43),
      BitmapDescriptor.asset(config, Assets.playbackParkingIcon,
          width: 32, height: 32),
    ]);
    if (!mounted) return;
    setState(() {
      _carIcon = icons[0];
      _startIcon = icons[1];
      _endIcon = icons[2];
      _parkingIcon = icons[3];
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _map?.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------ playback

  void _togglePlay() => _playing ? _pause() : _play();

  void _play() {
    if (_index >= _route.length - 1) _index = 0;
    setState(() => _playing = true);
    _restartTimer();
  }

  void _pause() {
    _timer?.cancel();
    if (mounted) setState(() => _playing = false);
  }

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: 300 ~/ _speeds[_speedIndex]),
      (_) {
        if (_index >= _route.length - 1) {
          _pause();
          return;
        }
        setState(() => _index++);
        _map?.animateCamera(CameraUpdate.newLatLng(_route[_index]));
      },
    );
  }

  void _changeSpeed() {
    setState(() => _speedIndex = (_speedIndex + 1) % _speeds.length);
    if (_playing) _restartTimer();
  }

  void _seek(double fraction) {
    setState(() =>
        _index = (fraction.clamp(0.0, 1.0) * (_route.length - 1)).round());
  }

  double _bearing(LatLng a, LatLng b) {
    double rad(double d) => d * math.pi / 180;
    final dLng = rad(b.longitude - a.longitude);
    final y = math.sin(dLng) * math.cos(rad(b.latitude));
    final x = math.cos(rad(a.latitude)) * math.sin(rad(b.latitude)) -
        math.sin(rad(a.latitude)) * math.cos(rad(b.latitude)) * math.cos(dLng);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  void _fitRoute() {
    final lats = _route.map((p) => p.latitude);
    final lngs = _route.map((p) => p.longitude);
    _map?.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(lats.reduce(math.min), lngs.reduce(math.min)),
        northeast: LatLng(lats.reduce(math.max), lngs.reduce(math.max)),
      ),
      70,
    ));
  }

  // ---------------------------------------------------------------- UI

  @override
  Widget build(BuildContext context) {
    final current = _route[_index];
    final next = _index < _route.length - 1 ? _route[_index + 1] : null;
    final rotation = next != null
        ? _bearing(current, next)
        : _route.length > 1
            ? _bearing(_route[_route.length - 2], current)
            : 0.0;

    return Scaffold(
      appBar: ReportAppBar(
        title: controller.reportType.screenTitle,
        subtitle: controller.vehicleTitle,
      ),
      body: Column(
        children: [
          _buildPlaybackBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _route.first, zoom: 14),
                    onMapCreated: (c) {
                      _map = c;
                      Future.delayed(
                          const Duration(milliseconds: 300), _fitRoute);
                    },
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    padding: EdgeInsets.only(bottom: 220.h),
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: _route,
                        color: _isOverspeed
                            ? const Color(0xffff2020)
                            : const Color(0xff22e02a),
                        width: 5,
                        jointType: JointType.round,
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('start'),
                        position: _route.first,
                        icon: _startIcon ?? BitmapDescriptor.defaultMarker,
                        anchor: const Offset(0.5, 1),
                      ),
                      Marker(
                        markerId: const MarkerId('end'),
                        position: _route.last,
                        icon: _endIcon ?? BitmapDescriptor.defaultMarker,
                        anchor: const Offset(0.5, 1),
                      ),
                      for (var i = 0; i < _item.parkings.length; i++)
                        Marker(
                          markerId: MarkerId('parking_$i'),
                          position: _item.parkings[i],
                          icon: _parkingIcon ??
                              BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueOrange),
                          anchor: const Offset(0.5, 1),
                        ),
                      Marker(
                        markerId: const MarkerId('vehicle'),
                        position: current,
                        icon: _carIcon ??
                            BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen),
                        rotation: rotation,
                        flat: true,
                        anchor: const Offset(0.5, 0.5),
                        zIndexInt: 2,
                      ),
                    },
                  ),
                ),
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 14.h,
                  child: TripReportCard(
                    item: _item,
                    isOverspeed: _isOverspeed,
                    onTap: _fitRoute,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaybackBar() {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 10.w, 8.h),
      child: Row(
        children: [
          Material(
            color: ReportColors.panel,
            shape: const CircleBorder(),
            elevation: 4,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _togglePlay,
              child: SizedBox(
                width: 42.r,
                height: 42.r,
                child: Icon(
                  _playing ? Icons.pause : Icons.play_arrow,
                  color: AppColors.whiteColor,
                  size: 26.r,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(child: _buildTrack()),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: _changeSpeed,
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: const Color(0xff8c8c8c),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fast_forward,
                      color: AppColors.whiteColor, size: 28.r),
                  if (_speedIndex > 0)
                    Text(
                      '${_speeds[_speedIndex]}x',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrack() {
    return LayoutBuilder(builder: (context, constraints) {
      final carWidth = 44.w;
      final trackWidth = constraints.maxWidth - carWidth;
      final left = trackWidth * _progress;
      void seek(double dx) => _seek((dx - carWidth / 2) / trackWidth);

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => seek(d.localPosition.dx),
        onHorizontalDragStart: (_) => _pause(),
        onHorizontalDragUpdate: (d) => seek(d.localPosition.dx),
        child: SizedBox(
          height: 44.h,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: carWidth / 2,
                right: 0,
                child: Container(height: 1.5, color: const Color(0xff2e7d32)),
              ),
              Positioned(
                left: left,
                child: Icon(Icons.directions_car_filled,
                    color: const Color(0xff3fbf3f), size: carWidth),
              ),
            ],
          ),
        ),
      );
    });
  }
}
