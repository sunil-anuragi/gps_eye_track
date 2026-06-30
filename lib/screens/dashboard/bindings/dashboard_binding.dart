import 'package:get/get.dart';
import 'package:gps_software/screens/dashboard/viewModel/dashboard_view_model.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardViewModel>(() => DashboardViewModel());
  }
}
