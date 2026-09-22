import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/screens/share_location/view/share_location_view.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:share_plus/share_plus.dart';

enum _ShareChoice { duration, current }

/// "Share Location" popup from the vehicle menu.
/// Duration → list of time-limited shares; Current → share the position now.
Future<void> showShareLocationDialog({
  required Map<String, dynamic> vehicle,
  required String vehicleNo,
  required double latitude,
  required double longitude,
}) async {
  final choice = await Get.dialog<_ShareChoice>(const _ShareLocationDialog());
  switch (choice) {
    case _ShareChoice.duration:
      Get.toNamed(
        ShareLocationView.shareLocationView,
        arguments: {
          ...vehicle,
          'latitude': latitude,
          'longitude': longitude,
        },
      );
    case _ShareChoice.current:
      await Share.share(
        '$vehicleNo current location\n'
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
        subject: '$vehicleNo location',
      );
    case null:
      break;
  }
}

class _ShareLocationDialog extends StatelessWidget {
  const _ShareLocationDialog();

  @override
  Widget build(BuildContext context) {
    return BadgeDialog(
      title: 'Share Location',
      titleColor: Colors.black,
      titleSize: 18,
      badge: Container(
        width: 64.r,
        height: 64.r,
        decoration: const BoxDecoration(
          color: Color(0xff29b6d6),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.share, color: AppColors.whiteColor, size: 32.r),
      ),
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              badgeDialogButton('Share Location (Duration)',
                  () => Get.back(result: _ShareChoice.duration)),
              SizedBox(height: 10.h),
              badgeDialogButton('Share Location (Current)',
                  () => Get.back(result: _ShareChoice.current)),
              SizedBox(height: 16.h),
              badgeDialogButton('Cancel', Get.back, radius: 30),
            ],
          ),
        ),
      ],
    );
  }
}
