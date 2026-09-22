import 'package:get/get.dart';
import 'package:gps_software/screens/change_password/viewModel/change_password_view_model.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordViewModel>(() => ChangePasswordViewModel());
  }
}
