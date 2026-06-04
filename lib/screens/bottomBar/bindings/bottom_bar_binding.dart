import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/viewModel/bottom_bar_view_model.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarViewModel>(
      () => BottomBarViewModel(),
    );
  }
}
