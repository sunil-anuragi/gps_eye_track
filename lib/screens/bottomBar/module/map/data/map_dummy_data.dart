import 'package:gps_software/screens/bottomBar/module/map/helper/map_vehicle_marker_icon.dart';
import 'package:gps_software/util/app_constant.dart';

class MapDummyData {
  MapDummyData._();

  static const List<MapVehicleMarker> vehicles = [
    MapVehicleMarker(
      id: 'DL2RQ-3478',
      latitude: 28.7041,
      longitude: 77.2650,
      status: MapVehicleMarkerStatus.running,
      address: AppStrings.sampleLiveTrackAddress,
      rotation: 0,
    ),
    MapVehicleMarker(
      id: 'DL6RQ-7562',
      latitude: 28.6995,
      longitude: 77.2720,
      status: MapVehicleMarkerStatus.stop,
      address: AppStrings.sampleDistanceAddress,
      rotation: 45,
    ),
    MapVehicleMarker(
      id: 'DL2RAA2389',
      latitude: 28.7060,
      longitude: 77.2680,
      status: MapVehicleMarkerStatus.offline,
      address: 'Bhajanpura, Shahdara, New Delhi, Delhi 110053, India',
      rotation: 90,
    ),
    MapVehicleMarker(
      id: 'ACUTE140',
      latitude: 28.7005,
      longitude: 77.2640,
      status: MapVehicleMarkerStatus.running,
      address: 'Maujpur, Shahdara, New Delhi, Delhi 110053, India',
      rotation: 135,
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3479',
      latitude: 28.6980,
      longitude: 77.2665,
      status: MapVehicleMarkerStatus.stop,
      address: 'Gokalpuri, Shahdara, New Delhi, Delhi 110094, India',
      rotation: 180,
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3480',
      latitude: 28.7075,
      longitude: 77.2710,
      status: MapVehicleMarkerStatus.offline,
      address: 'Jyoti Nagar, Shahdara, New Delhi, Delhi 110094, India',
      rotation: 225,
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3481',
      latitude: 28.7018,
      longitude: 77.2595,
      status: MapVehicleMarkerStatus.running,
      address: 'Welcome, Shahdara, New Delhi, Delhi 110053, India',
      rotation: 270,
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3482',
      latitude: 28.6955,
      longitude: 77.2610,
      status: MapVehicleMarkerStatus.stop,
      address: 'Dilshad Garden, Shahdara, New Delhi, Delhi 110095, India',
      rotation: 315,
    ),
  ];

  static String get defaultAddress => vehicles.first.address;
}
