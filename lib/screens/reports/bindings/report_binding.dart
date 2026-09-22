import 'package:get/get.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportViewModel>(() => ReportViewModel());
  }
}
