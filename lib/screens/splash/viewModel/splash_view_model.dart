import 'dart:async';
import 'package:get/get.dart';
import 'package:gps_software/screens/authentications/view/sign_in_view.dart';
import 'package:gps_software/util/base_controller.dart';

class SplashViewModel extends BaseController {
  @override
  Future<void> onInit() async {
    Timer(const Duration(seconds: 2), () async {
      Get.offAllNamed(SignInView.signInView);
    });
    super.onInit();
  }
}
