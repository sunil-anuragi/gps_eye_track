import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

/// Places that can be searched around the vehicle
enum NearbyPlace {
  atm('ATM', 'atm'),
  petrolPump('PETROL PUMP', 'petrol pump'),
  hospital('HOSPITAL', 'hospital'),
  policeStation('POLICE STATION', 'police station'),
  serviceStation('SERVICE STATION', 'car service station'),
  shoppingMalls('SHOPPING MALLS', 'shopping mall'),
  restaurants('RESTAURANTS', 'restaurant');

  const NearbyPlace(this.label, this.query);

  final String label;

  /// Google Maps search term
  final String query;
}

/// "Near By" popup: pick a place type to search around the vehicle
/// in Google Maps.
Future<void> showNearbyDialog({
  required String vehicleNo,
  required double latitude,
  required double longitude,
}) async {
  final place = await Get.dialog<NearbyPlace>(
    _NearbyDialog(vehicleNo: vehicleNo),
  );
  if (place == null) return;

  final uri = Uri.parse(
    'https://www.google.com/maps/search/'
    '${Uri.encodeComponent(place.query)}/@$latitude,$longitude,15z',
  );
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    Fluttertoast.showToast(msg: 'Unable to open Google Maps');
  }
}

class _NearbyDialog extends StatelessWidget {
  const _NearbyDialog({required this.vehicleNo});

  final String vehicleNo;

  @override
  Widget build(BuildContext context) {
    return BadgeDialog(
      title: 'Near By',
      horizontalInset: 44,
      badge: const _NearbyBadge(),
      children: [
        badgeDialogSubtitle(vehicleNo, fontSize: 13),
        SizedBox(height: 16.h),
        for (final place in NearbyPlace.values) ...[
          _button(place.label, () => Get.back(result: place)),
          SizedBox(height: 8.h),
        ],
        _button('CANCEL', Get.back),
      ],
    );
  }

  Widget _button(String label, VoidCallback onTap) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: badgeDialogButton(
          label,
          onTap,
          height: 38,
          radius: 8,
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Purple → blue diamond from the design
class _NearbyBadge extends StatelessWidget {
  const _NearbyBadge();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff4f7cff), Color(0xffb44cff), Color(0xffe44cf0)],
      ).createShader(bounds),
      child: Transform.rotate(
        angle: 0.785398, // 45°
        child: Container(
          width: 38.r,
          height: 38.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(color: Colors.white, width: 6.r),
          ),
          child: Center(
            child: Container(
              width: 12.r,
              height: 12.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                border: Border.all(color: Colors.white, width: 3.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
