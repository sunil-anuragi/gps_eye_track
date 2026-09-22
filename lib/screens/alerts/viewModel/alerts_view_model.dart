import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/alerts/model/vehicle_alert.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:intl/intl.dart';

class AlertsViewModel extends BaseController {
  late final Map<String, dynamic> vehicle;
  late final String vehicleNo;

  final alerts = <VehicleAlert>[].obs;
  final isLoading = false.obs;

  static final DateFormat timeFormat = DateFormat('dd-MMM-yyyy hh:mm:ss a');

  @override
  void onInit() {
    super.onInit();
    vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'DL23RW8855';
    loadAlerts();
  }

  /// Loads the vehicle's alerts. Replace [_mockAlerts] with the alerts API.
  Future<void> loadAlerts() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    alerts.assignAll(_mockAlerts());
    isLoading.value = false;
  }

  List<VehicleAlert> _mockAlerts() {
    const addresses = [
      'Sheoghanj Sumerpur Bypass Rd, sthan 06902 Manjialpur police station, Makarpura',
      'NH16, Bankra, Howrah, West Bengal 711403',
      'Andul Road, Alampur, Howrah, West Bengal 711302',
    ];
    final random = math.Random(vehicleNo.hashCode);
    final now = DateTime.now();
    return List.generate(12, (i) {
      // Mostly over-speed, like the design, with a few other events mixed in
      final type = i % 4 == 3
          ? AlertType.values[1 + random.nextInt(AlertType.values.length - 1)]
          : AlertType.overSpeed;
      return VehicleAlert(
        vehicleNo: vehicleNo,
        type: type,
        time: now.subtract(Duration(minutes: 37 * i + random.nextInt(30))),
        position: LatLng(
          22.555 + random.nextDouble() * 0.045,
          88.175 + random.nextDouble() * 0.105,
        ),
        address: addresses[random.nextInt(addresses.length)],
        speed:
            type == AlertType.overSpeed ? 61 + random.nextInt(40) * 1.0 : null,
      );
    });
  }
}
