import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gps_software/enum/vehicle_status.dart';

class AppColors {
  static const Color primaryColor = Color(0xff404040);
  static const Color primary2Color = Color(0xff635571);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(0xff18111F);
  static const Color redColor = Color(0xffC4302B);
  static const Color grayColor = Color(0xff9E9C9C);
  static const Color borderGrayColor = Color(0xffE5E7EB);
  static const Color textFieldTextColor = Color(0xff555555);
  static const Color iconGrayColor = Color(0xff8A7F94);
  static const Color datePickerHeaderColor = Color(0xffD8D4DB);
  static const Color logoutRedColor = Color(0xffE81F1F);
  static const Color darkBlack = Color(0xFF121212);

  // Custom colors for auth module
  static const Color blueColor = Color(0xff4285F4);
  static const Color subtitleColor = Color(0xFF757575);
  static const Color black87 = Color(0xDD000000);
  static const Color black54 = Color(0x8A000000);

  // Bottom bar & home module
  static const Color activeTabColor = Color(0xffC4302B);
  static const Color statusRunningColor = Color(0xff2E7D32);
  static const Color statusRunningBgColor = Color(0xffE8F5E9);
  static const Color statusStopColor = Color(0xff29B6F6);
  static const Color statusStopBgColor = Color(0xffE1F5FE);
  static const Color statusIdleColor = Color(0xffFFA726);
  static const Color statusIdleBgColor = Color(0xffFFF3E0);
  static const Color statusOfflineColor = Color(0xff757575);
  static const Color statusOfflineBgColor = Color(0xffEEEEEE);
  static const Color statusAllColor = Color(0xff9E9E9E);
  static const Color statusAllBgColor = Color(0xffF5F5F5);
  static const Color textGreenColor = Color(0xff4CAF50);
  static const Color textRedColor = Color(0xffF44336);
  static const Color searchBgColor = Color(0xffF0F0F0);
  static const Color dividerColor = Color(0xffE0E0E0);
  static const Color mapOverlayColor = Color(0xCC333333);
  static const Color geofenceBlueColor = Color(0xff29B6F6);
  static const Color geofenceCircleFillColor = Color(0x4D9E9E9E);
  static const Color screenBgColor = Color(0xffF5F5F5);
  static const Color supportTealColor = Color(0xff00BCD4);
  static const Color supportWhatsAppColor = Color(0xff25D366);
  static const Color supportMailBlueColor = Color(0xff42A5F5);

  static MaterialColor primaryColorShades = MaterialColor(
    primaryColor.value,
    <int, Color>{
      50: _getShade(primaryColor, 0.9), // Lightest
      100: _getShade(primaryColor, 0.8),
      200: _getShade(primaryColor, 0.6),
      300: _getShade(primaryColor, 0.4),
      400: _getShade(primaryColor, 0.2),
      500: primaryColor, // Primary Color
      600: _getShade(primaryColor, -0.1),
      700: _getShade(primaryColor, -0.2),
      800: _getShade(primaryColor, -0.3),
      900: _getShade(primaryColor, -0.4), // Darkest
    },
  );

  static Color _getShade(Color color, double factor) {
    HSLColor hslColor = HSLColor.fromColor(color);
    double newLightness = (factor >= 0)
        ? hslColor.lightness + factor * (1 - hslColor.lightness)
        : hslColor.lightness * (1 + factor);
    newLightness = newLightness.clamp(0.0, 1.0);
    return hslColor.withLightness(newLightness).toColor();
  }

  static MaterialColor gray = const MaterialColor(
    0xFF616161,
    <int, Color>{
      50: Color(0xFFFDFDFD),
      100: Color(0xFFF6F6F6),
      200: Color(0xFFF4F4F4),
      300: Color(0xFFEEEEEE),
      400: Color(0xFFEBEBEB),
      500: Color(0xFFE6E6E6),
      600: Color(0xFFD1D1D1),
      700: Color(0xFFA3A3A3),
      800: Color(0xFF7F7F7F),
      900: Color(0xFF616161),
    },
  );
}

class AppImage {
  static const String _basePath = "assets";
  static const String _vehicleBasePath = "$_basePath/vehicle";

  static String ace({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/ace.png";
  }

  static String bike({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/bike.png";
  }

  static String bus({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/bus.png";
  }

  static String car({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/car.png";
  }

  static String container({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/container.png";
  }

  static String cylinderTruck({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/cylinder_truck.png";
  }

  static String jcb({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/jcb.png";
  }

  static String loader({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/loader.png";
  }

  static String openTruck({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/open_truck.png";
  }

  static String rmcTruck({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/rmc_truck.png";
  }

  static String tipper({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/tipper.png";
  }

  static String tractor({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/tractor.png";
  }

  static String truck({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/truck.png";
  }

  static String manLifter({VehicleStatus type = VehicleStatus.out}) {
    bool isGpsPointApp = dotenv.get('IS_GPS_POINT_APP') == "true";
    return "$_vehicleBasePath/${type == (isGpsPointApp ? VehicleStatus.inactive : VehicleStatus.parking) ? "BLUE" : type == (isGpsPointApp ? VehicleStatus.parking : VehicleStatus.out) ? "RED" : type == VehicleStatus.moving ? "GREEN" : type == VehicleStatus.expired ? "PURPLE" : type == (isGpsPointApp ? VehicleStatus.out : VehicleStatus.inactive) ? "GRAY" : type == VehicleStatus.idle ? "YELLOW" : "YELLOW"}/man_lifter.png";
  }
}

extension SizeBoxWidget on double {
  Widget sizeBoxFromHeight() {
    return SizedBox(height: this);
  }

  Widget sizeBoxFromWidth() {
    return SizedBox(width: this);
  }
}

class AppStrings {
  static const String appTitle = "Sangeetbhati";
  static const String me = "Me";
  static const String map = "Map";
  static const String list = "List";
  static const String notification = "Notification";
  static const String account = "Account";
  static const String searchPlaceholder = "Search...";
  static const String all = "All";
  static const String running = "Running";
  static const String stop = "Stop";
  static const String idle = "Idle";
  static const String offline = "Offline";
  static const String pwr = "PWR";
  static const String gps = "GPS";
  static const String ign = "IGN";
  static const String on = "ON";
  static const String off = "OFF";
  static const String userNameLabel = "User Name :";
  static const String generateReports = "Generate reports";
  static const String geofence = "Geofence";
  static const String markerAnimation = "Marker Animation";
  static const String changePassword = "Change Password";
  static const String helpAndSupport = "Help and Support";
  static const String deleteAccount = "Delete Account";
  static const String logOut = "Log Out";
  static const String version = "version";
  static const String refreshIn = "Refresh In";
  static const String sec = "sec";
  static const String ignitionOn = "Ignition On";
  static const String createGeofence = "Create Geofence";
  static const String enterName = "Enter Name";
  static const String cancel = "Cancel";
  static const String save = "Save";
  static const String saveUpper = "SAVE";
  static const String circularRadius = "Circular Radius";
  static const String mtr = "mtr";
  static const String gpsSoftware = "GPS Software";
  static const String currentPassword = "Current Password";
  static const String newPassword = "New Password";
  static const String confirmPassword = "Confirm Password";
  static const String changePasswordUpper = "CHANGE PASSWORD";
  static const String slowMotion = "Slow Motion";
  static const String jumpMotion = "Jump Motion";
  static const String ok = "Ok";
  static const String weAreHappyToHelp = "We are happy to help you";
  static const String supportSubtitle =
      "We and our team are ready to assist you in any way, please tell us your problem by calling or messaging us!";
  static const String contactInformation = "Contact Information";
  static const String mobile = "Mobile";
  static const String email = "Email";
  static const String supportMobile = "81305045000";
  static const String supportEmail = "support@acutecommunication";
  static const String deleteAccountMessage = "Are you sure delete account !";
  static const String cancelUpper = "CANCEL";
  static const String confirmUpper = "CONFIRM";
}

class AuthStrings {
  static const String gpsSoftware = "GPS Software";
  static const String signIn = "Sign In";
  static const String account = "Account";
  static const String password = "Password";
  static const String passwordHint = "********";
  static const String rememberMe = "Remember me";
  static const String forgetPasswordLink = "Forget Password?";
  static const String login = "Login";

  static const String forgetPasswordTitle = "Forget Password";
  static const String forgetPasswordSubtitle = "Enter your user account to reset password";
  static const String enterUserId = "Enter your user id";
  static const String continueBtn = "Continue";

  static const String resetPasswordTitle = "Reset Password";
  static const String resetPasswordSubtitle = "Select option to reset password";
  static const String registerEmail = "Register Email Id: ac***********@gmail.com";
  static const String registerMobile = "Register Mobile No: **********7078";

  static const String congratulations = "Congratulations";
  static const String successSubtitle = "Awesome, you've successfully password send";
  static const String goToLogin = "Go To Login";
}

class MQTT {
  static String mqttUrl = '';
  static int mqttPort = 0;
  static String userName = '';
  static String password = '';
  static int keepAlivePeriod = 60;

  static void setConfig({
    required String url,
    required int port,
    required String user,
    required String pass,
    int keepAlive = 60,
  }) {
    mqttUrl = url;
    mqttPort = port;
    userName = user;
    password = pass;
    keepAlivePeriod = keepAlive;
  }
}
