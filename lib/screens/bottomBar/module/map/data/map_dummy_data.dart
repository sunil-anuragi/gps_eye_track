import 'package:gps_software/commonWidget/vehicle_map_tooltip.dart';
import 'package:gps_software/screens/bottomBar/module/map/helper/map_vehicle_marker_icon.dart';
import 'package:gps_software/util/app_constant.dart';

class MapDummyData {
  MapDummyData._();

  static VehicleMapTooltipData tooltipFor({
    required String id,
    required MapVehicleMarkerStatus status,
    String? speed,
  }) {
    final statusLabel = switch (status) {
      MapVehicleMarkerStatus.running => AppStrings.sampleRunningStatus,
      MapVehicleMarkerStatus.stop => 'Stop (0 Km/h)',
      MapVehicleMarkerStatus.offline => AppStrings.sampleOfflineStatus,
    };

    return VehicleMapTooltipData(
      vehicleId: id,
      vehicleCode: AppStrings.sampleVehicleCode,
      time: AppStrings.sampleLiveTrackTime,
      status: statusLabel,
      engine: AppStrings.offString,
      externalPower: AppStrings.onString,
      distance: AppStrings.sampleLiveDistance,
      todayKm: AppStrings.sampleTodayKm,
      speed: speed ?? AppStrings.sampleLiveSpeed,
    );
  }

  static const List<MapVehicleMarker> vehicles = [
    MapVehicleMarker(
      id: 'DL2RQ-3478',
      latitude: 28.7041,
      longitude: 77.2650,
      status: MapVehicleMarkerStatus.running,
      address: AppStrings.sampleLiveTrackAddress,
      rotation: 0,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL2RQ-3478',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: AppStrings.sampleRunningStatus,
        engine: AppStrings.offString,
        externalPower: AppStrings.onString,
        distance: AppStrings.sampleLiveDistance,
        todayKm: AppStrings.sampleTodayKm,
        speed: AppStrings.sampleLiveSpeed,
      ),
    ),
    MapVehicleMarker(
      id: 'DL6RQ-7562',
      latitude: 28.6995,
      longitude: 77.2720,
      status: MapVehicleMarkerStatus.stop,
      address: AppStrings.sampleDistanceAddress,
      rotation: 45,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL6RQ-7562',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: 'Stop (0 Km/h)',
        engine: AppStrings.offString,
        externalPower: AppStrings.onString,
        distance: AppStrings.sampleLiveDistance,
        todayKm: AppStrings.sampleTodayKm,
        speed: '0.0Km',
      ),
    ),
    MapVehicleMarker(
      id: 'DL2RAA2389',
      latitude: 28.7060,
      longitude: 77.2680,
      status: MapVehicleMarkerStatus.offline,
      address: 'Bhajanpura, Shahdara, New Delhi, Delhi 110053, India',
      rotation: 90,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL2RAA2389',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: AppStrings.sampleOfflineStatus,
        engine: AppStrings.offString,
        externalPower: AppStrings.offString,
        distance: AppStrings.sampleLiveDistance,
        todayKm: AppStrings.sampleTodayKm,
        speed: '0.0Km',
      ),
    ),
    MapVehicleMarker(
      id: 'ACUTE140',
      latitude: 28.7005,
      longitude: 77.2640,
      status: MapVehicleMarkerStatus.running,
      address: 'Maujpur, Shahdara, New Delhi, Delhi 110053, India',
      rotation: 135,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'ACUTE140',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: AppStrings.sampleRunningStatus,
        engine: AppStrings.onString,
        externalPower: AppStrings.onString,
        distance: '6.10 Km',
        todayKm: '98.20 Km',
        speed: '32.5Km',
      ),
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3479',
      latitude: 28.6980,
      longitude: 77.2665,
      status: MapVehicleMarkerStatus.stop,
      address: 'Gokalpuri, Shahdara, New Delhi, Delhi 110094, India',
      rotation: 180,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL2RQ-3479',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: 'Stop (12 Min)',
        engine: AppStrings.offString,
        externalPower: AppStrings.onString,
        distance: AppStrings.sampleLiveDistance,
        todayKm: AppStrings.sampleTodayKm,
        speed: '0.0Km',
      ),
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3480',
      latitude: 28.7075,
      longitude: 77.2710,
      status: MapVehicleMarkerStatus.offline,
      address: 'Jyoti Nagar, Shahdara, New Delhi, Delhi 110094, India',
      rotation: 225,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL2RQ-3480',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: AppStrings.sampleOfflineStatus,
        engine: AppStrings.offString,
        externalPower: AppStrings.offString,
        distance: AppStrings.sampleLiveDistance,
        todayKm: AppStrings.sampleTodayKm,
        speed: '0.0Km',
      ),
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3481',
      latitude: 28.7018,
      longitude: 77.2595,
      status: MapVehicleMarkerStatus.running,
      address: 'Welcome, Shahdara, New Delhi, Delhi 110053, India',
      rotation: 270,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL2RQ-3481',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: AppStrings.sampleRunningStatus,
        engine: AppStrings.onString,
        externalPower: AppStrings.onString,
        distance: '2.80 Km',
        todayKm: '76.40 Km',
        speed: '18.0Km',
      ),
    ),
    MapVehicleMarker(
      id: 'DL2RQ-3482',
      latitude: 28.6955,
      longitude: 77.2610,
      status: MapVehicleMarkerStatus.stop,
      address: 'Dilshad Garden, Shahdara, New Delhi, Delhi 110095, India',
      rotation: 315,
      tooltip: VehicleMapTooltipData(
        vehicleId: 'DL2RQ-3482',
        vehicleCode: AppStrings.sampleVehicleCode,
        time: AppStrings.sampleLiveTrackTime,
        status: 'Stop (5 Min)',
        engine: AppStrings.offString,
        externalPower: AppStrings.onString,
        distance: AppStrings.sampleLiveDistance,
        todayKm: AppStrings.sampleTodayKm,
        speed: '0.0Km',
      ),
    ),
  ];

  static String get defaultAddress => vehicles.first.address;
}
