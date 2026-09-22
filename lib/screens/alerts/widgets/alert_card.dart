import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/alerts/model/vehicle_alert.dart';
import 'package:gps_software/screens/alerts/viewModel/alerts_view_model.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/util/app_constant.dart';

/// Alert row: navy block with the alert icon, vehicle, description and time.
/// Set [showAddress] to add the address line (used on the alert map).
class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.alert,
    this.onTap,
    this.showAddress = false,
  });

  final VehicleAlert alert;
  final VoidCallback? onTap;
  final bool showAddress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 96.w,
                color: ReportColors.panel,
                alignment: Alignment.center,
                child: AlertIconBadge(alert: alert),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 6.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidget.text(
                        alert.vehicleNo,
                        color: ReportColors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                      SizedBox(height: 4.h),
                      CustomWidget.text(
                        alert.description,
                        color: ReportColors.greyText,
                        fontSize: 13,
                        letterSpacing: 0,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      CustomWidget.text(
                        AlertsViewModel.timeFormat.format(alert.time),
                        color: ReportColors.greyText,
                        fontSize: 13,
                        letterSpacing: 0,
                      ),
                      if (showAddress) ...[
                        SizedBox(height: 6.h),
                        CustomWidget.text(
                          alert.address,
                          color: ReportColors.text,
                          fontSize: 12.5,
                          letterSpacing: 0,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, right: 8.w),
                child: Icon(Icons.chevron_right,
                    color: Colors.grey.shade500, size: 22.r),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// White round badge: a crossed-out speed sign for over-speed,
/// otherwise the alert type's icon.
class AlertIconBadge extends StatelessWidget {
  const AlertIconBadge({super.key, required this.alert});

  final VehicleAlert alert;

  @override
  Widget build(BuildContext context) {
    final size = 46.r;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(5.r),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
      ),
      child: alert.type == AlertType.overSpeed
          ? _SpeedSign(limit: '50')
          : Icon(alert.type.icon, color: ReportColors.endDot, size: 26.r),
    );
  }
}

class _SpeedSign extends StatelessWidget {
  const _SpeedSign({required this.limit});

  final String limit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffe53935), width: 2.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomWidget.text(
            limit,
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
          Transform.rotate(
            angle: 0.785398,
            child: Container(
              width: 2.5,
              height: 32.r,
              color: const Color(0xffe53935),
            ),
          ),
        ],
      ),
    );
  }
}
