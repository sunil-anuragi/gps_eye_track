import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/bindings/account_binding.dart';
import 'package:gps_software/screens/bottomBar/viewModel/bottom_bar_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/map/viewModel/map_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/notification/viewModel/notification_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarViewModel>(() => BottomBarViewModel());
    Get.lazyPut<MapViewModel>(() => MapViewModel());
    Get.lazyPut<VehicleListViewModel>(() => VehicleListViewModel());
    Get.lazyPut<NotificationViewModel>(() => NotificationViewModel());
    AccountBinding().dependencies();
  }
}
