import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/screens/alerts/model/vehicle_alert.dart';
import 'package:gps_software/screens/alerts/widgets/alert_card.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';

/// One alert on the map, with its card on top.
/// Argument: the [VehicleAlert].
class AlertMapView extends StatefulWidget {
  static const alertMapView = '/alertMapView';

  const AlertMapView({super.key});

  @override
  State<AlertMapView> createState() => _AlertMapViewState();
}

class _AlertMapViewState extends State<AlertMapView> {
  late final VehicleAlert _alert = Get.arguments as VehicleAlert;
  GoogleMapController? _map;

  @override
  void dispose() {
    _map?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReportAppBar(title: _alert.vehicleNo),
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _alert.position, zoom: 15),
              onMapCreated: (c) => _map = c,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              padding: EdgeInsets.only(top: 150.h),
              markers: {
                Marker(
                  markerId: const MarkerId('alert'),
                  position: _alert.position,
                  infoWindow: InfoWindow(
                    title: _alert.type.label,
                    snippet: _alert.address,
                  ),
                ),
              },
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            top: 10.h,
            child: AlertCard(
              alert: _alert,
              showAddress: true,
              onTap: () => _map?.animateCamera(
                CameraUpdate.newLatLngZoom(_alert.position, 16),
              ),
            ),
          ),
          Positioned(
            right: 16.w,
            bottom: 30.h,
            child: MapZoomControls(controller: () => _map),
          ),
        ],
      ),
    );
  }
}
