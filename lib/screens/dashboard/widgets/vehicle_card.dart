import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/enum/vehicle_status.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/get_vehicle_image.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicleNo,
    required this.vehicleType,
    required this.todayKm,
    required this.speed,
    required this.status,
    required this.lastUpdate,
    required this.odo,
    required this.expiryDate,
    required this.isExpired,
    required this.speedLimit,
    this.onLoadAddress,
  });

  final String vehicleNo;
  final String vehicleType;
  final String todayKm;
  final String speed;
  final String status;
  final String lastUpdate;
  final String odo;
  final String expiryDate;
  final bool isExpired;
  final String speedLimit;
  final VoidCallback? onLoadAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Vehicle Tag
              Container(
                padding: EdgeInsets.fromLTRB(12.w, 6.h, 16.w, 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xff18548f),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: CustomWidget.text(
                  '$vehicleNo | ${vehicleType.toUpperCase()}',
                  color: AppColors.whiteColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
              // Today's Distance
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CustomWidget.text(
                  'Today - $todayKm',
                  color: AppColors.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),

          // Body Row
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Vehicle Image, Speed & Expiry
                SizedBox(
                  width: 100.w,
                  child: Column(
                    children: [
                      Image.asset(
                        getVehicleImage(vehicleType, VehicleStatus.moving),
                        width: 75.w,
                        height: 50.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4.h),
                      CustomWidget.text(
                        speed,
                        color: AppColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      CustomWidget.text(
                        isExpired ? 'Expired' : 'Active',
                        color: isExpired
                            ? AppColors.logoutRedColor
                            : AppColors.runningColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                      CustomWidget.text(
                        expiryDate,
                        color: AppColors.grayColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Right Column: Last Update, Status, Odo, Speed Limit & Indicators
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Speed Limit Sign
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 1.r),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Column(
                              children: [
                                CustomWidget.text(
                                  'SPEED\nLIMIT',
                                  fontSize: 6,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackColor,
                                  textAlign: TextAlign.center,
                                  letterSpacing: 0,
                                ),
                                CustomWidget.text(
                                  speedLimit,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.blackColor,
                                  textAlign: TextAlign.center,
                                  letterSpacing: 0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),

                          // Vehicle text details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomWidget.text(
                                  'Last Update : $lastUpdate',
                                  color: AppColors.logoutRedColor,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                CustomWidget.text(
                                  status,
                                  color: AppColors.runningColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                CustomWidget.text(
                                  'ODO : $odo',
                                  color: AppColors.blackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Indicators Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildIndicator(Icons.satellite_alt_outlined, 'GPS'),
                          SizedBox(width: 14.w),
                          _buildIndicator(
                              Icons.battery_charging_full_outlined, '100%'),
                          SizedBox(width: 14.w),
                          _buildIndicator(Icons.key, 'IGN'),
                          SizedBox(width: 14.w),
                          _buildIndicator(Icons.bolt, 'PWR'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Address Loader Bar
          GestureDetector(
            onTap: onLoadAddress,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xff18548f).withValues(alpha: 0.08),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.logoutRedColor,
                      size: 12.r,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  CustomWidget.text(
                    'Click here to load Address',
                    color: const Color(0xff18548f),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(IconData iconData, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: AppColors.runningColor,
          size: 16.r,
        ),
        SizedBox(height: 1.h),
        CustomWidget.text(
          label,
          fontSize: 7.5,
          color: AppColors.grayColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ],
    );
  }
}
