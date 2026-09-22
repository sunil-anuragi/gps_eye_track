import 'package:get/get.dart';
import 'package:gps_software/screens/alerts/viewModel/alerts_view_model.dart';

class AlertsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertsViewModel>(() => AlertsViewModel());
  }
}
