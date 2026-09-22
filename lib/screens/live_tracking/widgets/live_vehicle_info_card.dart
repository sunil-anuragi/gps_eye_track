import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

/// Bottom card on the live tracking screen: vehicle, speed, status,
/// device indicators and the current address.
class LiveVehicleInfoCard extends StatelessWidget {
  const LiveVehicleInfoCard({
    super.key,
    required this.title,
    required this.speed,
    required this.lastUpdate,
    required this.status,
    required this.isRunning,
    required this.address,
  });

  final String title;
  final String speed;
  final String lastUpdate;
  final String status;
  final bool isRunning;
  final String address;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        isRunning ? AppColors.runningColor : AppColors.logoutRedColor;

    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 12.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 6.h),
            child: CustomWidget.text(
              title,
              color: const Color(0xff4a4a4a),
              fontSize: 15,
              letterSpacing: 0,
              maxLine: 1,
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            color: TrackingColors.divider,
          ),

          // Body
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 92.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: statusColor,
                          size: 44.r,
                        ),
                        CustomWidget.text(
                          speed,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  color: TrackingColors.divider,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 8.h, 10.w, 6.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _oneLine(CustomWidget.text(
                          'Last Update : $lastUpdate',
                          fontSize: 12,
                          letterSpacing: 0,
                          maxLine: 1,
                        )),
                        SizedBox(height: 2.h),
                        _oneLine(CustomWidget.text(
                          status,
                          color: statusColor,
                          fontSize: 12,
                          letterSpacing: 0,
                          maxLine: 1,
                        )),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          color: TrackingColors.divider,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _indicator(Icons.satellite_alt, 'GPS',
                                AppColors.runningColor),
                            _separator(),
                            _indicator(Icons.battery_charging_full, '100%',
                                AppColors.runningColor),
                            _separator(),
                            _indicator(
                                Icons.key,
                                'IGN',
                                isRunning
                                    ? AppColors.runningColor
                                    : AppColors.logoutRedColor),
                            _separator(),
                            _indicator(
                                Icons.power, 'PWR', AppColors.runningColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Address
          Container(
            color: TrackingColors.brandBlue,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 44.w,
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.whiteColor,
                      size: 24.r,
                    ),
                  ),
                  Container(width: 1.5, color: Colors.white70),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 10.h),
                      child: CustomWidget.text(
                        address,
                        color: AppColors.whiteColor,
                        fontSize: 13,
                        letterSpacing: 0,
                        maxLine: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(IconData icon, String label, Color color) {
    return SizedBox(
      width: 36.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.r),
          CustomWidget.text(label, fontSize: 9, letterSpacing: 0, maxLine: 1),
        ],
      ),
    );
  }

  Widget _separator() => Container(
        width: 1,
        height: 26.h,
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        color: TrackingColors.divider,
      );

  Widget _oneLine(Widget child) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: child,
      );
}
