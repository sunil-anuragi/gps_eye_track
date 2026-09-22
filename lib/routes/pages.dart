import 'package:get/get.dart';
import 'package:gps_software/screens/alerts/bindings/alerts_binding.dart';
import 'package:gps_software/screens/alerts/view/alert_map_view.dart';
import 'package:gps_software/screens/alerts/view/alerts_view.dart';
import 'package:gps_software/screens/authentications/bindings/auth_binding.dart';
import 'package:gps_software/screens/authentications/view/sign_in_view.dart';
import 'package:gps_software/screens/dashboard/bindings/dashboard_binding.dart';
import 'package:gps_software/screens/dashboard/view/dashboard_view.dart';
import 'package:gps_software/screens/dashboard/view/dashboard_vehicle_list_view.dart';
import 'package:gps_software/screens/dashboard/view/vehicle_menu_view.dart';
import 'package:gps_software/screens/history/bindings/history_binding.dart';
import 'package:gps_software/screens/history/view/history_view.dart';
import 'package:gps_software/screens/live_tracking/bindings/live_tracking_binding.dart';
import 'package:gps_software/screens/live_tracking/view/live_tracking_view.dart';
import 'package:gps_software/screens/reports/report_pages.dart';
import 'package:gps_software/screens/reports/view/all_reports_view.dart';
import 'package:gps_software/screens/vehicle_details/bindings/vehicle_details_binding.dart';
import 'package:gps_software/screens/vehicle_management/bindings/vehicle_management_binding.dart';
import 'package:gps_software/screens/vehicle_management/view/vehicle_management_view.dart';
import 'package:gps_software/screens/vehicle_details/view/vehicle_details_view.dart';
import 'package:gps_software/screens/vehicle_details/view/vehicle_icon_change_view.dart';

import 'package:gps_software/screens/share_location/bindings/share_location_binding.dart';
import 'package:gps_software/screens/share_location/view/share_location_view.dart';
import 'package:gps_software/screens/change_password/bindings/change_password_binding.dart';
import 'package:gps_software/screens/change_password/view/change_password_view.dart';
import 'package:gps_software/screens/geofence/bindings/geofence_binding.dart';
import 'package:gps_software/screens/geofence/view/add_geofence_view.dart';
import 'package:gps_software/screens/geofence/view/geofence_view.dart';
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
        name: DashboardView.dashboardView,
        page: () => const DashboardView(),
        binding: DashboardBinding(),
        transition: transition),
    GetPage(
        name: DashboardVehicleListView.dashboardVehicleListView,
        page: () => const DashboardVehicleListView(),
        binding: DashboardBinding(),
        transition: transition),
    GetPage(
        name: VehicleMenuView.vehicleMenuView,
        page: () => const VehicleMenuView(),
        binding: DashboardBinding(),
        transition: transition),
    GetPage(
        name: LiveTrackingView.liveTrackingView,
        page: () => const LiveTrackingView(),
        binding: LiveTrackingBinding(),
        transition: transition),
    GetPage(
        name: HistoryView.historyView,
        page: () => const HistoryView(),
        binding: HistoryBinding(),
        transition: transition),
    GetPage(
        name: AllReportsView.allReportsView,
        page: () => const AllReportsView(),
        transition: transition),
    ...ReportPages.routes(transition: transition),
    GetPage(
        name: AlertsView.alertsView,
        page: () => const AlertsView(),
        binding: AlertsBinding(),
        transition: transition),
    GetPage(
        name: AlertMapView.alertMapView,
        page: () => const AlertMapView(),
        transition: transition),
    GetPage(
        name: VehicleManagementView.vehicleManagementView,
        page: () => const VehicleManagementView(),
        binding: VehicleManagementBinding(),
        transition: transition),
    GetPage(
        name: ShareLocationView.shareLocationView,
        page: () => const ShareLocationView(),
        binding: ShareLocationBinding(),
        transition: transition),
    GetPage(
        name: VehicleDetailsView.vehicleDetailsView,
        page: () => const VehicleDetailsView(),
        binding: VehicleDetailsBinding(),
        transition: transition),
    // Uses the VehicleDetailsViewModel of the details screen below it
    GetPage(
        name: VehicleIconChangeView.vehicleIconChangeView,
        page: () => const VehicleIconChangeView(),
        transition: transition),
    GetPage(
        name: GeofenceView.geofenceView,
        page: () => const GeofenceView(),
        binding: GeofenceBinding(),
        transition: transition),
    GetPage(
        name: AddGeofenceView.addGeofenceView,
        page: () => const AddGeofenceView(),
        binding: AddGeofenceBinding(),
        transition: transition),
    GetPage(
        name: ChangePasswordView.changePasswordView,
        page: () => const ChangePasswordView(),
        binding: ChangePasswordBinding(),
        transition: transition),
  ];
}
