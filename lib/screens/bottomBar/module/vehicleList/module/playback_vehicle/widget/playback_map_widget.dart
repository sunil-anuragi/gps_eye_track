import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';

class PlaybackMapWidget extends GetView<VehicleListViewModel> {
  const PlaybackMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
        initialCameraPosition: CameraPosition(
          target: VehicleListViewModel.playbackRoute.first,
          zoom: 14,
        ),
        mapType: controller.playbackMapType.value,
        onMapCreated: controller.onPlaybackMapCreated,
        markers: controller.playbackMarkers.value,
        polylines: controller.playbackPolylines.value,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        trafficEnabled: false,
      ),
    );
  }
}
