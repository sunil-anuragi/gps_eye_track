import 'package:get/get.dart';
import 'package:gps_software/screens/splash/viewModel/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(),
    );
  }
}
