import 'package:get/get.dart';
import 'package:gps_software/screens/settings/viewModel/setting_view_model.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingViewModel>(() => SettingViewModel());
  }
}
