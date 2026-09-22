import 'package:get/get.dart';
import 'package:gps_software/screens/vehicle_details/model/vehicle_icon_option.dart';
import 'package:gps_software/screens/vehicle_details/view/vehicle_icon_change_view.dart';
import 'package:gps_software/util/base_controller.dart';

class VehicleDetailsViewModel extends BaseController {
  late final Map<String, dynamic> vehicle;
  late final String vehicleNo;

  /// Icon saved for the vehicle
  final selectedIcon = VehicleIconOption.all.first.obs;

  /// Icon highlighted on the change-icon screen before saving
  final pendingIcon = VehicleIconOption.all.first.obs;

  @override
  void onInit() {
    super.onInit();
    vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'DL23RW8855';
    selectedIcon.value =
        VehicleIconOption.byKey(vehicle['vehicleType'] as String? ?? 'car');
  }

  String _value(String key, String fallback) =>
      vehicle[key]?.toString() ?? fallback;

  /// Label/value rows shown on the details screen (the icon row is separate)
  List<MapEntry<String, String>> get detailRows => [
        MapEntry('IMEI', _value('imei', '33126176123763876')),
        MapEntry('Sim Card', _value('simCard', '565404427736')),
        MapEntry('Model', _value('model', 'CONCOX')),
        MapEntry('Activation Time',
            _value('activationTime', '26-Dec-2022 12:00:00 Am')),
        MapEntry(
            'Expire Date', _value('expireDate', '26-Dec-2023 12:00:00 Am')),
        MapEntry('Status', _value('status', 'Offline (61 Day, 12 Hr, 39 Min)')),
        MapEntry('Gps Time', _value('gpsTime', '26-May-2022 12:00:00 Am')),
        MapEntry(
            'Latest Update', _value('lastUpdate', '26-Dec-2023 12:00:00 Am')),
        MapEntry('Speed', _value('speed', '0.0 kph')),
        MapEntry('Coordinate', _value('coordinate', '28.505637,77.3949')),
        MapEntry(
            'Engine Status', _value('engineStatus', '26-Dec-2022 12:00:00 Am')),
      ];

  void openIconPicker() {
    pendingIcon.value = selectedIcon.value;
    Get.toNamed(VehicleIconChangeView.vehicleIconChangeView);
  }

  /// Saves the highlighted icon. Call the update-vehicle API here.
  void saveIcon() {
    selectedIcon.value = pendingIcon.value;
    Get.back();
    showSnack(msg: 'Vehicle icon updated');
  }
}
