import 'package:get/get.dart';
import 'package:gps_software/screens/vehicle_management/viewModel/vehicle_management_view_model.dart';

class VehicleManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleManagementViewModel>(() => VehicleManagementViewModel());
  }
}
