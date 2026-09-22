import 'package:get/get.dart';
import 'package:gps_software/screens/live_tracking/viewModel/live_tracking_view_model.dart';

class LiveTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveTrackingViewModel>(() => LiveTrackingViewModel());
  }
}
