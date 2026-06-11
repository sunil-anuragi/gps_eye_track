import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/bottomBar/module/map/viewModel/map_view_model.dart';

class MapGoogleMapWidget extends GetView<MapViewModel> {
  const MapGoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
        initialCameraPosition: controller.initialCameraPosition,
        mapType: controller.mapType.value,
        markers: Set<Marker>.from(controller.markers),
        onMapCreated: controller.onMapCreated,
        onCameraMove: controller.onCameraMove,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        buildingsEnabled: true,
        trafficEnabled: false,
      ),
    );
  }
}
