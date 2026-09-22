import 'package:get/get.dart';
import 'package:gps_software/screens/vehicle_details/viewModel/vehicle_details_view_model.dart';

class VehicleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailsViewModel>(() => VehicleDetailsViewModel());
  }
}
