import 'package:get/get.dart';
import 'package:gps_software/screens/authentications/viewModel/auth_view_model.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthViewModel>(() => AuthViewModel(), fenix: true);
  }
}
