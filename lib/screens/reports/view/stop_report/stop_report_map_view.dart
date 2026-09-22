import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/model/report_type.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/view/stop_report/widgets/stop_report_card.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

/// Map of stop / idle / AC locations.
/// Arguments: `items` (List<StopReportItem>), `selected` (int, optional).
/// With `selected` only that stop is shown; otherwise every stop is pinned.
class StopReportMapView extends StatefulWidget {
  static const stopReportMapView = '/stopReportMapView';

  const StopReportMapView({super.key});

  @override
  State<StopReportMapView> createState() => _StopReportMapViewState();
}

class _StopReportMapViewState extends State<StopReportMapView> {
  final ReportViewModel controller = Get.find<ReportViewModel>();
  late final List<StopReportItem> _items;
  late int _selected;
  GoogleMapController? _map;

  @override
  void initState() {
    super.initState();
    final args = (Get.arguments as Map<String, dynamic>?) ?? {};
    final all = (args['items'] as List?)?.cast<StopReportItem>() ??
        controller.itemsOf<StopReportItem>();
    final selected = args['selected'] as int?;
    _items = selected != null ? [all[selected]] : all;
    _selected = 0;
  }

  @override
  void dispose() {
    _map?.dispose();
    super.dispose();
  }

  void _fitAll() {
    if (_items.length < 2) return;
    final lats = _items.map((i) => i.location.position.latitude);
    final lngs = _items.map((i) => i.location.position.longitude);
    _map?.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(lats.reduce(math.min), lngs.reduce(math.min)),
        northeast: LatLng(lats.reduce(math.max), lngs.reduce(math.max)),
      ),
      70,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isAc = controller.reportType == ReportType.ac;
    return Scaffold(
      appBar: ReportAppBar(
        title: 'Report',
        subtitle: controller.vehicleTitle,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _items.first.location.position,
                zoom: 15,
              ),
              onMapCreated: (c) {
                _map = c;
                Future.delayed(const Duration(milliseconds: 300), _fitAll);
              },
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              padding: EdgeInsets.only(bottom: 130.h),
              markers: {
                for (var i = 0; i < _items.length; i++)
                  Marker(
                    markerId: MarkerId('stop_$i'),
                    position: _items[i].location.position,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      i == _selected
                          ? BitmapDescriptor.hueRed
                          : BitmapDescriptor.hueRose,
                    ),
                    zIndexInt: i == _selected ? 1 : 0,
                    onTap: () => setState(() => _selected = i),
                  ),
              },
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 14.h,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: StopReportCard(
                key: ValueKey(_selected),
                item: _items[_selected],
                elevated: true,
                startLabel: isAc ? 'ON Time' : 'Start Time',
                endLabel: isAc ? 'OFF Time' : 'End Time',
                onTap: () => _map?.animateCamera(CameraUpdate.newLatLngZoom(
                    _items[_selected].location.position, 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
