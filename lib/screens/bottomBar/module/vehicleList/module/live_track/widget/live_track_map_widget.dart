import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';

class LiveTrackMapWidget extends GetView<VehicleListViewModel> {
  const LiveTrackMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GoogleMap(
        initialCameraPosition: controller.liveTrackCameraPosition,
        mapType: controller.liveTrackMapType.value,
        markers: controller.liveTrackMarkers.value,
        onMapCreated: controller.onLiveTrackMapCreated,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        buildingsEnabled: true,
        trafficEnabled: false,
      );
    });
  }
}
