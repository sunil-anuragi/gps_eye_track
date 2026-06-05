import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';

class GeofenceMapWidget extends GetView<AccountViewModel> {
  const GeofenceMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GoogleMap(
        initialCameraPosition: controller.geofenceInitialCameraPosition,
        onMapCreated: controller.onGeofenceMapCreated,
        markers: controller.geofenceMarkers.value,
        circles: controller.geofenceCircles.value,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
      );
    });
  }
}
