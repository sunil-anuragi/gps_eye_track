import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/base_controller.dart';

class NotificationItem {
  final String vehicleId;
  final String message;
  final String timestamp;

  const NotificationItem({
    required this.vehicleId,
    required this.message,
    required this.timestamp,
  });
}

class NotificationViewModel extends BaseController {
  final List<NotificationItem> notifications = const [
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
     NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
     NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
    NotificationItem(
      vehicleId: 'DL2RAA2389',
      message: AppStrings.ignitionOn,
      timestamp: '13-Jul-2023 04:02:52 PM',
    ),
  ];
}
