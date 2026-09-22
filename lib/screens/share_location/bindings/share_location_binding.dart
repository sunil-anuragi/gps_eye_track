import 'package:get/get.dart';
import 'package:gps_software/screens/share_location/viewModel/share_location_view_model.dart';

class ShareLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareLocationViewModel>(() => ShareLocationViewModel());
  }
}
