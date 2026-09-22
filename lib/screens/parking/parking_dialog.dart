import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Parking mode popup: shows whether parking alerts are on for the vehicle
/// and lets the user switch them.
Future<void> showParkingDialog(String vehicleNo) async {
  final enabled = await ParkingStore.isEnabled(vehicleNo);
  final result = await Get.dialog<bool>(
    _ParkingDialog(vehicleNo: vehicleNo, isEnabled: enabled),
  );
  if (result == null) return;

  await ParkingStore.setEnabled(vehicleNo, result);
  Fluttertoast.showToast(
    msg: 'Parking ${result ? 'enabled' : 'disabled'} for $vehicleNo',
    backgroundColor: TrackingColors.brandBlue,
    textColor: AppColors.whiteColor,
  );
}

/// Keeps the parking state on the device.
/// Swap for the parking-mode API when it is available.
class ParkingStore {
  static String _key(String vehicleNo) => 'parking_enabled_$vehicleNo';

  static Future<bool> isEnabled(String vehicleNo) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key(vehicleNo)) ?? false;
  }

  static Future<void> setEnabled(String vehicleNo, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key(vehicleNo), value);
  }
}

class _ParkingDialog extends StatelessWidget {
  const _ParkingDialog({required this.vehicleNo, required this.isEnabled});

  final String vehicleNo;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return BadgeDialog(
      title: vehicleNo,
      children: [
        SizedBox(height: 2.h),
        badgeDialogSubtitle(
          isEnabled ? 'Parking Enabled' : 'Parking Disabled',
          fontSize: 13,
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(child: badgeDialogButton('Cancel', Get.back)),
            SizedBox(width: 12.w),
            Expanded(
              child: badgeDialogButton(
                isEnabled ? 'Disable' : 'Enable',
                () => Get.back(result: !isEnabled),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
