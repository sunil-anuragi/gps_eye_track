import 'package:get/get.dart';
import 'package:gps_software/screens/history/viewModel/history_view_model.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryViewModel>(() => HistoryViewModel());
  }
}
