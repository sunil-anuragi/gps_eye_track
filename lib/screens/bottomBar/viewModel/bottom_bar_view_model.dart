import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/view/account_view.dart';
import 'package:gps_software/screens/bottomBar/module/map/view/map_view.dart';
import 'package:gps_software/screens/bottomBar/module/notification/view/notification_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/view/vehicle_list_view.dart';
import 'package:gps_software/util/base_controller.dart';

class BottomBarViewModel extends BaseController {
  RxInt selectedIndex = 0.obs;
  RxString appVersion = "1.0.0".obs;

  void onTabSelected(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }

  List<Widget> buildMainScreen() {
    return const [
      MapView(),
      VehicleListView(),
      NotificationView(),
      AccountView(),
    ];
  }

  Future<void> checkConnectionStatus() async {}
  Future<void> getAppVersion() async {}
  Future<void> getExpiredList() async {}
  Future<void> checkVehicleSafeParkingAlertActive({dynamic allVehicle}) async {}
  Future<void> checkVehicleSafeParkingAlert() async {}
}
