import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/util/base_controller.dart';

class BottomBarViewModel extends BaseController {
  List<Widget> buildMainScreen() {
    return [
      const Center(child: Text("Vehicle")),
      const Center(child: Text("Map")),
      const Center(child: Text("Chart")),
      const Center(child: Text("Summary")),
      const Center(child: Text("Setting")),
    ];
  }

  List<Widget> buildSummaryScreen() {
    return [
      const Center(child: Text("Vehicle")),
      const Center(child: Text("Map")),
      const Center(child: Text("Summary")),
      const Center(child: Text("Setting")),
    ];
  }

  List<Widget> buildchartScreen() {
    return [
      const Center(child: Text("Vehicle")),
      const Center(child: Text("Map")),
      const Center(child: Text("Chart")),
      const Center(child: Text("Setting")),
    ];
  }

  RxInt selectedIndex = 0.obs;
  RxString appVersion = "1.0.0".obs;

  Future<void> checkConnectionStatus() async {}
  Future<void> getAppVersion() async {}
  Future<void> getExpiredList() async {}
  Future<void> checkVehicleSafeParkingAlertActive({dynamic allVehicle}) async {}
  Future<void> checkVehicleSafeParkingAlert() async {}
}
