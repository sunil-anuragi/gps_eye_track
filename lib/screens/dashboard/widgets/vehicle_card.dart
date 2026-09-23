import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';
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

  static const Color _addressBgColor = Color(0xffdde5f0);
  static final Color _lineColor = Colors.grey.shade300;

  String get _typeLabel => vehicleType.isEmpty
      ? vehicleType
      : vehicleType[0].toUpperCase() + vehicleType.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLeftSection(),
                Expanded(child: _buildRightSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header: vehicle tag (≈62% width) + today's distance on a single line
  Widget _buildHeader() {
    return SizedBox(
      height: 32.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 62,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: DashboardLogoMark.brandBlue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(22.r),
                ),
              ),
              child: _oneLine(
                CustomWidget.text(
                  '$vehicleNo | $_typeLabel',
                  color: AppColors.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                  maxLine: 1,
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          Expanded(
            flex: 38,
            child: Padding(
              padding: EdgeInsets.only(left: 6.w, right: 10.w),
              child: _oneLine(
                CustomWidget.text(
                  'Today - $todayKm',
                  color: AppColors.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  maxLine: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Left: vehicle image, speed, expiry
  Widget _buildLeftSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 0, 6.h),
      child: SizedBox(
        width: 92.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    getVehicleImage(
                      vehicleType,
                      vehicleStatusFromText(status, isExpired: isExpired),
                    ),
                    // The artwork is roughly 3:1, so width drives the size
                    // and this just reserves the row height.
                    height: 32.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(width: 1, height: 44.h, color: _lineColor),
              ],
            ),
            SizedBox(height: 6.h),
            CustomWidget.text(
              speed,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              maxLine: 1,
            ),
            CustomWidget.text(
              isExpired ? 'Expired' : 'Active',
              fontSize: 10,
              letterSpacing: 0,
              maxLine: 1,
            ),
            CustomWidget.text(
              expiryDate,
              fontSize: 10,
              letterSpacing: 0,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }

  // Right: status lines, speed limit, indicators, address bar
  Widget _buildRightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _oneLine(
                CustomWidget.text(
                  'Last Update : $lastUpdate',
                  color: AppColors.logoutRedColor,
                  fontSize: 11,
                  letterSpacing: 0,
                  maxLine: 1,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSpeedLimitSign(),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _oneLine(
                            CustomWidget.text(
                              status,
                              color: AppColors.runningColor,
                              fontSize: 11,
                              letterSpacing: 0,
                              maxLine: 1,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          _oneLine(
                            CustomWidget.text(
                              'ODO : $odo',
                              fontSize: 11,
                              letterSpacing: 0,
                              maxLine: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 1, color: _lineColor),
        Padding(
          padding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildIndicator(Icons.satellite_alt_outlined, 'GPS'),
              SizedBox(width: 16.w),
              _buildIndicator(Icons.battery_charging_full, '100%'),
              SizedBox(width: 16.w),
              _buildIndicator(Icons.key, 'IGN'),
              SizedBox(width: 16.w),
              _buildIndicator(Icons.power, 'PWR'),
            ],
          ),
        ),
        const Spacer(),
        _buildAddressBar(),
      ],
    );
  }

  Widget _buildSpeedLimitSign() {
    return Padding(
      padding: EdgeInsets.only(left: 2.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            padding: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.blackColor, width: 0.8),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomWidget.text(
                  'SPEED\nLIMIT',
                  fontSize: 4.5,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  letterSpacing: 0,
                ),
                CustomWidget.text(
                  speedLimit,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  letterSpacing: 0,
                ),
              ],
            ),
          ),
          Container(width: 1.5, height: 6.h, color: AppColors.blackColor),
        ],
      ),
    );
  }

  Widget _buildAddressBar() {
    return GestureDetector(
      onTap: onLoadAddress,
      child: Container(
        height: 30.h,
        padding: EdgeInsets.only(left: 18.w, right: 8.w),
        decoration: BoxDecoration(
          color: _addressBgColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(22.r)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: DashboardLogoMark.brandBlue,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.location_on,
                color: AppColors.logoutRedColor,
                size: 14.r,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _oneLine(
                CustomWidget.text(
                  'Click here to load Address',
                  color: DashboardLogoMark.brandBlue,
                  fontSize: 11,
                  letterSpacing: 0,
                  maxLine: 1,
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
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
          size: 15.r,
        ),
        CustomWidget.text(
          label,
          fontSize: 5,
          color: AppColors.blackColor,
          letterSpacing: 0,
        ),
      ],
    );
  }

  // Keeps text on a single line, shrinking it only if space runs out
  Widget _oneLine(Widget child,
      {AlignmentGeometry alignment = Alignment.centerRight}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: child,
    );
  }
}
