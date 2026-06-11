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
  static const Color subtitleColor = Color(0xFF333333);
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
  static const Color textGreenColor = Color(0xff05B541);
  static const Color textRedColor = Color(0xffF44336);
  static const Color searchBgColor = Color(0xffF0F0F0);
  static const Color dividerColor = Color(0xffD9D9D9);
  static const Color menuDividerColor = Color(0xffBFBFBF);
  static const Color mapOverlayColor = Color(0xCC333333);
  static const Color geofenceBlueColor = Color(0xff29B6F6);
  static const Color geofenceCircleFillColor = Color(0x4D9E9E9E);
  static const Color screenBgColor = Color(0xffF5F5F5);
  static const Color supportTealColor = Color(0xff00BFF0);
  static const Color supportWhatsAppColor = Color(0xff25D366);
  static const Color supportMailBlueColor = Color(0xff42A5F5);
  static const Color textColor = Color(0xffA8A8A8);
  static const Color allColor = Color(0xff615E5E);
  static const Color allInnerColor = Color(0xffEBEBEB);
  static const Color runningColor = Color(0xff007C2A);
  static const Color runningInnerColor = Color(0xff4AC373);
  static const Color stopColor = Color(0xff00CEFF);
  static const Color idleColor = Color(0xffFF9900);
  static const Color idleInnerColor = Color(0xffF9DEB5);
  static const Color offlineInnerColor = Color(0xffADADAD);
  static const Color offlineColor = Color(0xff414141);
  static const Color reportFilterBgColor = Color(0xff727475);
  static const Color reportSelectorBgColor = Color(0xffEBEBEB);
  static const Color cardBorderColor = Color(0xff8A8A8A);
  static const Color textGrayLightColor = Color(0xff8A8A8A);
  static const Color containerBgColor = Color(0xffF6F6F6);
  static const Color reportTextColor = Color(0xff434343);
  static const Color reportAddressTextColor = Color(0xff434343);
  static const Color bgConatinerColor = Color(0xff294FD7);
  static const Color text1Color = Color(0xff787878);
  static const Color switchActiveTrackColor = Color(0xffFDC6FE);
  static const Color switchInactiveTrackColor = Color(0xffD9D9D9);
  static const Color switchThumbColor = Color(0xffBDBDBD);
  static const Color fuelCutoffIconBgColor = Color(0xffEDE7F6);
  static const Color redlightColor = Color(0xffFF2F2F);

  // Playback vehicle screen
  static const Color playbackCardBg = Color(0xffFFFFFF);
  static const Color playbackHeaderBg = Color(0xff404040);
  static const Color playbackSpeedScaleBg = Color(0xffEEF2FF);
  static const Color playbackSpeedScaleBorder = Color(0xff3F51B5);
  static const Color playbackSpeedActiveColor = Color(0xff3F51B5);
  static const Color playbackSpeedInactiveColor = Color(0xffBDBDBD);
  static const Color playbackInfoLabelColor = Color(0xff787878);
  static const Color playbackInfoValueColor = Color(0xff18111F);
  static const Color playbackProgressTrack = Color(0xffE0E0E0);
  static const Color playbackProgressActive = Color(0xff3F51B5);
  static const Color playbackPlayBtnColor = Color(0xff3F51B5);
  static const Color playbackTimelineBg = Color(0xffF5F5F5);
  static const Color playbackRouteColor = Color(0xff05B541);
  static const Color playbackParkingColor = Color(0xffFF9900);

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
  static const String onString = "ON";
  static const String offString = "OFF";
  static const String userNameLabel = "User Name :";
  static const String generateReports = "Generate reports";
  static const String chaseTrack = "ChaseTrack";
  static const String selectVehicle = "Select Vehicle";
  static const String selectReportType = "Select Report type";
  static const String distanceReport = "DISTANCE REPORT";
  static const String stopReport = "STOP REPORT";
  static const String idleReport = "IDLE REPORT";
  static const String tripReport = "TRIP REPORT";
  static const String overspeedReport = "OVERSPEED REPORT";
  static const String geofenceReport = "GEOFENCE REPORT";
  static const String distanceReports = "DISTANCE REPORTS";
  static const String stopReports = "STOP REPORTS";
  static const String idleReports = "IDLE REPORTS";
  static const String tripReports = "TRIP REPORTS";
  static const String overspeedReports = "OVERSPEED REPORTS";
  static const String geofenceReports = "GEOFENCE REPORTS";
  static const String totalDistance = "Total Distance :";
  static const String sampleDistanceValue = "110.28 KM";
  static const String sampleReportDate = "2023-07-08";
  static const String sampleDistanceAddress =
      "Sheoghanj Sumerpur Bypass Rd, sthan 06902 Manjialpur police station, Makarpura....";
  static const String sampleGeofenceDateTime = "04-Jul-2023 05:12:54 PM";
  static const String sampleTimedReportDate = "Jul 13, 2023";
  static const String sampleReportTime = "12:06 Am";
  static const String sampleReportDuration = "00:06:13";
  static const String date = "Date";
  static const String oneHrAgo = "1 hr ago";
  static const String today = "Today";
  static const String yesterday = "Yesterday";
  static const String userDefined = "User-defined";
  static const String start = "Start";
  static const String end = "End";
  static const String avgSpeed = "Avg Speed";
  static const String startSpeed = "Start Speed";
  static const String endSpeed = "End Speed";
  static const String duration = "Duration";
  static const String maxSpeed = "Max Speed";
  static const String distance = "Distance";
  static const String reportSampleAddress =
      "Captain Gaur Marg, East of Kailash, New Delhi, New Delhi - 110065, India";
  static const String imei = "IMEI";
  static const String tracking = "Tracking";
  static const String liveTrack = "Live Track";
  static const String timeLabel = "Time";
  static const String engine = "Engine";
  static const String externalPower = "External Power";
  static const String todayKm = "Today Km";
  static const String sampleLiveTrackTime = "2023-07-13 17:24:44";
  static const String sampleRunningStatus = "Running (41.0 Km/h)";
  static const String sampleLiveDistance = "4.32 Km";
  static const String sampleTodayKm = "115.50 Km";
  static const String sampleLiveSpeed = "9.0Km";
  static const String sampleVehicleCode = "AC104";
  static const String sampleLiveTrackAddress =
      "C6/233 Bhagwan Shree Pashuram Rd, Block C, Yamuna Vihar, Shahdara, New Delhi, Delhi 110053, India";
  static const String immobilizeMessage =
      "enabling immobilize mode will immobilize your vehicle";
  static const String requiredLoginPassword = "*Required login password";
  static const String fuelSupplyCutOff = "Fuel Supply Cut Off";
  static const String fuelCutOffSuccessfully = "Fuel Cut Off Successfully !";
  static const String continueText = "Continue";
  static const String confirm = "Confirm";
  static const String geofenceConfirmPrefix =
      "Are you sure, to create a Circle Geo - fence (Radius : 300m) for";
  static const String yes = "Yes";
  static const String no = "No";
  static const String playback = "Playback";
  static const String detail = "Detail";
  static const String command = "Command";
  static const String alert = "Alert";
  static const String vehicleManagement = "Vehicle Management";
  static const String shareLocation = "Share Location";
  static const String overSpeed = "Over Speed";
  static const String submit = "Submit";
  static const String reports = "Reports";
  static const String sampleImei = "36423979739872";
  static const String shareLocationDuration = "Share Location (Duration)";
  static const String shareLocationCurrent = "Share Location (Current)";
  static const String edit = "Edit";
  static const String name = "Name";
  static const String icon = "Icon";
  static const String simCard = "Sim Card";
  static const String model = "Model";
  static const String activationTime = "Activation Time";
  static const String expireDate = "Expire Date";
  static const String status = "Status";
  static const String gpsTime = "Gps Time";
  static const String latestUpdate = "Latest Update";
  static const String speed = "Speed";
  static const String coordinate = "Coordinate";
  static const String engineStatus = "Engine Status";
  static const String active = "Active";
  static const String validTill = "Valid Till";
  static const String shareName = "Share Name";
  static const String sampleVehicleName = "DL23RW8855";
  static const String sampleSimCard = "565404427736";
  static const String sampleModel = "CONCOX";
  static const String sampleDateTime = "26-Dec-2022 12:00:00 Am";
  static const String sampleExpireDate = "26-Dec-2023 12:00:00 Am";
  static const String sampleOfflineStatus = "Offline (61 Day, 12 Hr, 39 Min)";
  static const String sampleGpsTime = "26-May-2022 12:00:00 Am";
  static const String sampleSpeed = "0.0 kph";
  static const String sampleCoordinate = "28.505637, 77.3949";
  static const String sampleShareTimestamp = "2023-07-09 16:19:00";
  static const String geofence = "Geofence";
  static const String markerAnimation = "Marker Animation";
  static const String changePassword = "Change Password";
  static const String helpAndSupport = "Help and Support";
  static const String deleteAccount = "Delete Account";
  static const String logOut = "Log Out";
  static const String version = "version";
  static const String refreshIn = "Refresh In";
  static const String sec = "sec";
  static const String receiveNotification = "Receive Notification";
  static const String voiceNotification = "Voice Notification";
  static const String alertOptionSetting = "Alert Option Setting";
  static const String ignition = "Ignition";
  static const String ac = "Ac";
  static const String power = "Power";
  static const String temper = "Temper";
  static const String sos = "SOS";
  static const String immobilizer = "Immobilizer";
  static const String parking = "Parking";
  static const String door = "Door";
  static const String promotion = "Promotion";
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

  // Playback vehicle screen
  static const String playbackVehicle = "Playback Vehicle";
  static const String setPlayBackTime = "Set Play Back Time";
  static const String speedScale = "Speed Scale";
  static const String selectSpeedScale = "Select Speed Scale";
  static const String slow = "Slow";
  static const String normal = "Normal";
  static const String fastSpeed = "Fast";
  static const String veryFast = "Very Fast";
  static const String speed1x = "1X";
  static const String normalSpeed = "1x (Normal)";
  static const String speed2x = "2x";
  static const String speed4x = "4x";
  static const String speed8x = "8x";
  static const String speed16x = "16x";
  static const String startPlayback = "Start";
  static const String pausePlayback = "Pause";
  static const String stopPlayback = "Stop";
  static const String tripDuration = "Trip Duration";
  static const String startTime = "Start Time";
  static const String endTime = "End Time";
  static const String vehicleNo = "Vehicle No";
  static const String currentSpeed = "Current Speed";
  static const String odometer = "Odometer";
  static const String location = "Location";
  static const String selectDate = "Select Date";
  static const String playbackRoute = "Playback Route";
  static const String kmh = "km/h";
  static const String km = "km";
  static const String vehicleId = "Vehicle ID";
  static const String mileage = "Mileage";
  static const String gpsTimeLabel = "Gps time";
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
  static const String forgetPasswordSubtitle =
      "Enter your user account to reset password";
  static const String enterUserId = "Enter your user id";
  static const String continueBtn = "Continue";

  static const String resetPasswordTitle = "Reset Password";
  static const String resetPasswordSubtitle = "Select option to reset password";
  static const String registerEmail =
      "Register Email Id: ac***********@gmail.com";
  static const String registerMobile = "Register Mobile No: **********7078";

  static const String congratulations = "Congratulations";
  static const String successSubtitle =
      "Awesome, you've successfully password send";
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
