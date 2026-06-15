import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/util/base_controller.dart';

class BottomBarViewModel extends BaseController {
  RxInt selectedIndex = 0.obs;
  RxString appVersion = "1.0.0".obs;

  void onTabSelected(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }



  Future<void> checkConnectionStatus() async {}
  Future<void> getAppVersion() async {}
  Future<void> getExpiredList() async {}
  Future<void> checkVehicleSafeParkingAlertActive({dynamic allVehicle}) async {}
  Future<void> checkVehicleSafeParkingAlert() async {}
}
