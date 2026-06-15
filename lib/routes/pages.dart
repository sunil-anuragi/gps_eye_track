import 'package:get/get.dart';
import 'package:gps_software/screens/authentications/bindings/auth_binding.dart';
import 'package:gps_software/screens/authentications/view/sign_in_view.dart';
import 'package:gps_software/screens/authentications/view/forget_password_view.dart';
import 'package:gps_software/screens/authentications/view/reset_password_view.dart';
import 'package:gps_software/screens/splash/bindings/splash_binding.dart';
import 'package:gps_software/screens/splash/view/splash_view.dart';

const Transition transition = Transition.cupertino;

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = SplashView.splashView;

  static final routes = [
    GetPage(
        name: SplashView.splashView,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: transition),
    GetPage(
        name: SignInView.signInView,
        page: () => const SignInView(),
        binding: AuthBinding(),
        transition: transition),
    GetPage(
        name: ForgetPasswordView.forgetPasswordView,
        page: () => const ForgetPasswordView(),
        binding: AuthBinding(),
        transition: transition),
    GetPage(
        name: ResetPasswordView.resetPasswordView,
        page: () => const ResetPasswordView(),
        binding: AuthBinding(),
        transition: transition),
 
  ];
}
