import 'package:get/get.dart';
import 'package:gps_software/screens/geofence/viewModel/add_geofence_view_model.dart';
import 'package:gps_software/screens/geofence/viewModel/geofence_view_model.dart';

class GeofenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeofenceViewModel>(() => GeofenceViewModel());
  }
}

class AddGeofenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddGeofenceViewModel>(() => AddGeofenceViewModel());
  }
}
