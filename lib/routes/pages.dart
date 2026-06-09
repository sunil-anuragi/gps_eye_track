import 'package:get/get.dart';
import 'package:gps_software/screens/authentications/bindings/auth_binding.dart';
import 'package:gps_software/screens/authentications/view/sign_in_view.dart';
import 'package:gps_software/screens/authentications/view/forget_password_view.dart';
import 'package:gps_software/screens/authentications/view/reset_password_view.dart';
import 'package:gps_software/screens/bottomBar/bindings/bottom_bar_binding.dart';
import 'package:gps_software/screens/bottomBar/view/bottom_bar_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/bindings/account_binding.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/change_password/view/change_password_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/view/geofence_list_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/view/geofence_map_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/generate_report/view/generate_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/distance_report/view/distance_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/live_track/view/live_track_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/share_location/view/share_location_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_detail/view/vehicle_detail_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_menu/view/vehicle_menu_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/view/alert_option_setting_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_notification/view/vehicle_notification_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/geofence_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/idle_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/overspeed_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/stop_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/trip_report_view.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/vehicle_reports/view/vehicle_reports_view.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/help_support/view/help_support_view.dart';
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
    GetPage(
        name: BottomBarView.bottomBarView,
        page: () => const BottomBarView(),
        transition: transition,
        binding: BottomBarBinding()),
    GetPage(
        name: GeofenceListView.geofenceListView,
        page: () => const GeofenceListView(),
        binding: AccountBinding(),
        transition: transition),
    GetPage(
        name: GeofenceMapView.geofenceMapView,
        page: () => const GeofenceMapView(),
        binding: AccountBinding(),
        transition: transition),
    GetPage(
        name: ChangePasswordView.changePasswordView,
        page: () => const ChangePasswordView(),
        binding: AccountBinding(),
        transition: transition),
    GetPage(
        name: HelpSupportView.helpSupportView,
        page: () => const HelpSupportView(),
        binding: AccountBinding(),
        transition: transition),
    GetPage(
        name: GenerateReportView.generateReportView,
        page: () => const GenerateReportView(),
        binding: AccountBinding(),
        transition: transition),
    GetPage(
        name: VehicleMenuView.vehicleMenuView,
        page: () => const VehicleMenuView(),
        transition: transition),
    GetPage(
        name: VehicleDetailView.vehicleDetailView,
        page: () => const VehicleDetailView(),
        transition: transition),
    GetPage(
        name: ShareLocationView.shareLocationView,
        page: () => const ShareLocationView(),
        transition: transition),
    GetPage(
        name: VehicleReportsView.vehicleReportsView,
        page: () => const VehicleReportsView(),
        transition: transition),
    GetPage(
        name: DistanceReportView.distanceReportView,
        page: () => const DistanceReportView(),
        transition: transition),
    GetPage(
        name: StopReportView.stopReportView,
        page: () => const StopReportView(),
        transition: transition),
    GetPage(
        name: IdleReportView.idleReportView,
        page: () => const IdleReportView(),
        transition: transition),
    GetPage(
        name: TripReportView.tripReportView,
        page: () => const TripReportView(),
        transition: transition),
    GetPage(
        name: OverspeedReportView.overspeedReportView,
        page: () => const OverspeedReportView(),
        transition: transition),
    GetPage(
        name: GeofenceReportView.geofenceReportView,
        page: () => const GeofenceReportView(),
        transition: transition),
    GetPage(
        name: VehicleNotificationView.vehicleNotificationView,
        page: () => const VehicleNotificationView(),
        transition: transition),
    GetPage(
        name: AlertOptionSettingView.alertOptionSettingView,
        page: () => const AlertOptionSettingView(),
        transition: transition),
    GetPage(
        name: LiveTrackView.liveTrackView,
        page: () => const LiveTrackView(),
        transition: transition),
  ];
}
