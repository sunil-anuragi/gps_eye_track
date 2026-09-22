import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/get_vehicle_image.dart';
import 'package:gps_software/enum/vehicle_status.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/alerts/view/alerts_view.dart';
import 'package:gps_software/screens/engine_control/engine_control_dialogs.dart';
import 'package:gps_software/screens/history/view/history_view.dart';
import 'package:gps_software/screens/live_tracking/view/live_tracking_view.dart';
import 'package:gps_software/screens/nearby/nearby_dialog.dart';
import 'package:gps_software/screens/parking/parking_dialog.dart';
import 'package:gps_software/screens/reports/view/all_reports_view.dart';
import 'package:gps_software/screens/share_location/widgets/share_location_dialog.dart';
import 'package:gps_software/screens/vehicle_details/view/vehicle_details_view.dart';
import 'package:gps_software/screens/vehicle_management/view/vehicle_management_view.dart';
import 'package:gps_software/screens/vehicle_settings/vehicle_value_dialogs.dart';

class VehicleMenuView extends StatelessWidget {
  static const vehicleMenuView = '/vehicleMenuView';

  const VehicleMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get arguments from the list view, or fallback to mock data
    final Map<String, dynamic> vehicle =
        Get.arguments as Map<String, dynamic>? ??
            {
              'vehicleNo': 'NL01AD8732',
              'vehicleType': 'truck',
              'todayKm': '87.08KM',
              'speed': '0.0 km/h',
              'status': 'Stopped',
              'lastUpdate': '07-Jul-2023 05:19:45 PM',
              'odo': '7744.08Km',
              'expiryDate': 'Nov 09,2023',
              'isExpired': true,
              'speedLimit': '60',
            };

    final String vehicleNo = vehicle['vehicleNo'] as String? ?? 'NL01AD8732';
    final String vehicleType = vehicle['vehicleType'] as String? ?? 'truck';
    final String speed = vehicle['speed'] as String? ?? '0.0 km/h';

    double lat = 22.5327; // Default to Dhulagarh Industrial Park
    double lng = 88.2045;
    if (vehicle['coordinate'] != null) {
      final parts = (vehicle['coordinate'] as String).split(',');
      if (parts.length == 2) {
        lat = double.tryParse(parts[0].trim()) ?? lat;
        lng = double.tryParse(parts[1].trim()) ?? lng;
      }
    } else if (vehicle['latitude'] != null && vehicle['longitude'] != null) {
      lat = double.tryParse(vehicle['latitude'].toString()) ?? lat;
      lng = double.tryParse(vehicle['longitude'].toString()) ?? lng;
    }

    // Parse status and duration
    String statusText = vehicle['status'] as String? ?? 'Stopped';
    String durationText = '';
    if (statusText.contains('(') && statusText.contains(')')) {
      final startIndex = statusText.indexOf('(');
      final endIndex = statusText.indexOf(')');
      durationText = statusText.substring(startIndex + 1, endIndex).trim();
      statusText = statusText.substring(0, startIndex).trim();
    } else {
      if (statusText.toLowerCase() == 'stopped') {
        durationText = '24 Min, 17 Sec';
      } else {
        durationText = '0 Min, 0 Sec';
      }
    }

    // // Determine VehicleStatus enum for image loading
    // VehicleStatus statusEnum = VehicleStatus.out;
    // if (statusText.toLowerCase().contains('run')) {
    //   statusEnum = VehicleStatus.moving;
    // } else if (statusText.toLowerCase().contains('stop')) {
    //   statusEnum = VehicleStatus.parking;
    // } else if (statusText.toLowerCase().contains('idle')) {
    //   statusEnum = VehicleStatus.idle;
    // }

    // final String vehicleImage = getVehicleImage(vehicleType, statusEnum);

    return Scaffold(
      backgroundColor: const Color(0xfff3f6f9),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Curved Navy Gradient Background
                      Container(
                        height: 300.h,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff18548f),
                              Color(0xff0d3a68),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        right: -60.w,
                        top: 120.h,
                        child: Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.95),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 0,
                        top: 0,
                        child: ClipPath(
                          clipper: ArrowTabClipper(),
                          child: Container(
                            width: 75.w,
                            height: 95.h,
                            color: const Color(0xff0c2440),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15.h, bottom: 10.h, right: 12.w),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.whiteColor,
                                    size: 35.w,
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 105.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Vehicle registration name | Type
                            CustomWidget.text(
                              '$vehicleNo | ${vehicleType.toUpperCase()}',
                              color: AppColors.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ).paddingOnly(left: 5.w),

                            SizedBox(height: 10.h),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff0c2440),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: CustomWidget.text(
                                    statusText,
                                    color: AppColors.whiteColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                CustomWidget.text(
                                  durationText,
                                  color: AppColors.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),

                            SizedBox(height: 40.h),

                            Row(
                              children: [
                                Image.asset(
                                  Assets.icSpeed,
                                  fit: BoxFit.fill,
                                  height: 50,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomWidget.text(
                                      'Speed',
                                      color: AppColors.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomWidget.text(
                                      speed.toUpperCase(),
                                      color: AppColors.whiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 25.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomWidget.text(
                          'Location',
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 140.h,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat, lng),
                                zoom: 15.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId(vehicleNo),
                                  position: LatLng(lat, lng),
                                  infoWindow: InfoWindow(
                                    title: vehicleNo,
                                    snippet: statusText,
                                  ),
                                ),
                              },
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              gestureRecognizers: <Factory<
                                  OneSequenceGestureRecognizer>>{
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // More Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomWidget.text(
                          'More',
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1.h,
                          height: 12.h,
                        ),
                        SizedBox(height: 4.h),

                        // 3x4 Grid of options
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 1.25,
                          padding: EdgeInsets.only(bottom: 30.h),
                          children: [
                            _buildGridItem(
                              'Live Track',
                              Assets.vehicleMenuTracking,
                              onTap: () => Get.toNamed(
                                LiveTrackingView.liveTrackingView,
                                arguments: vehicle,
                              ),
                            ),
                            _buildGridItem(
                              'History',
                              Assets.vehicleMenuPlayback,
                              onTap: () => Get.toNamed(
           
                                HistoryView.historyView,
                                arguments: vehicle,
                              ),
                            ),
                            _buildGridItem('Reports', Assets.vehicleMenuReports,
                                onTap: () {
                              print("data");
                              Get.toNamed(
                                AllReportsView.allReportsView,
                                arguments: vehicle,
                              );
                            }),
                            _buildGridItem(
                              'Details',
                              Assets.vehicleMenuDetail,
                              onTap: () => Get.toNamed(
                                VehicleDetailsView.vehicleDetailsView,
                                arguments: vehicle,
                              ),
                            ),
                            _buildGridItem(
                              'Engine',
                              Assets.vehicleMenuCommand,
                              onTap: () => showEngineControl(vehicleNo),
                            ),
                            _buildGridItem(
                              'Parking',
                              Assets.playbackParkingIcon,
                              onTap: () => showParkingDialog(vehicleNo),
                            ),
                            _buildGridItem(
                              'Alerts',
                              Assets.vehicleMenuAlert,
                              onTap: () => Get.toNamed(
                                AlertsView.alertsView,
                                arguments: vehicle,
                              ),
                            ),
                            _buildGridItem(
                              'Near By',
                              null,
                              iconData: Icons.sensors,
                              onTap: () => showNearbyDialog(
                                vehicleNo: vehicleNo,
                                latitude: lat,
                                longitude: lng,
                              ),
                            ),
                            _buildGridItem(
                              'Share',
                              Assets.vehicleMenuShare,
                              onTap: () => showShareLocationDialog(
                                vehicle: vehicle,
                                vehicleNo: vehicleNo,
                                latitude: lat,
                                longitude: lng,
                              ),
                            ),
                            _buildGridItem(
                              'odometer',
                              Assets.vehicleMenuImei,
                              onTap: () => showVehicleSettingDialog(
                                VehicleSetting.odometer,
                                vehicleNo: vehicleNo,
                                currentValue: vehicle['odo'] as String?,
                              ),
                            ),
                            _buildGridItem(
                              'Over Speed',
                              Assets.vehicleMenuOverspeed,
                              onTap: () => showVehicleSettingDialog(
                                VehicleSetting.overSpeed,
                                vehicleNo: vehicleNo,
                                currentValue: vehicle['speedLimit'] as String?,
                              ),
                            ),
                            _buildGridItem(
                              'Management',
                              Assets.vehicleMenuManagement,
                              onTap: () => Get.toNamed(
                                VehicleManagementView.vehicleManagementView,
                                arguments: vehicle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: -15.w,
                top: -510,
                bottom: 0.h,
                // Decorative only: let taps reach the grid underneath
                child: IgnorePointer(
                  child: Image.asset(
                    Assets.carImage,
                    width: 190.w,
                    height: 190.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String? assetPath,
      {IconData? iconData, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Get.snackbar(
              title,
              'Opening $title...',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xff18548f),
              colorText: AppColors.whiteColor,
              duration: const Duration(milliseconds: 1500),
            );
          },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff18548f),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (assetPath != null)
              Image.asset(
                assetPath,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              )
            else if (iconData != null)
              Icon(
                iconData,
                color: AppColors.whiteColor,
                size: 24.w,
              ),
            SizedBox(height: 6.h),
            CustomWidget.text(
              title,
              color: AppColors.whiteColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Clipper for the curved blue header bar background
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 35.h);
    // Asymmetric smooth downward curve towards the right edge
    path.quadraticBezierTo(
      size.width * 0.65,
      size.height,
      size.width,
      size.height - 75.h,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Clipper for the dark blue curved back arrow tab (top-left)
class ArrowTabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    // Draw a curved sweep from bottom-left corner to right edge, making a rounded arc
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.9,
      size.width,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
