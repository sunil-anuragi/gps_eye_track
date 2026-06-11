import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleMapTooltipData {
  final String vehicleId;
  final String vehicleCode;
  final String time;
  final String status;
  final String engine;
  final String externalPower;
  final String distance;
  final String todayKm;
  final String speed;

  const VehicleMapTooltipData({
    required this.vehicleId,
    required this.vehicleCode,
    required this.time,
    required this.status,
    required this.engine,
    required this.externalPower,
    required this.distance,
    required this.todayKm,
    required this.speed,
  });
}

class VehicleMapTooltip extends StatelessWidget {
  const VehicleMapTooltip({
    super.key,
    required this.data,
  });

  final VehicleMapTooltipData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 220.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.mapOverlayColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidget.text(
                '${data.vehicleId}(${data.vehicleCode})',
                color: AppColors.whiteColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              4.h.sizeBoxFromHeight(),
              _infoRow('${AppStrings.timeLabel} :', data.time),
              _infoRow('${AppStrings.status} :', data.status),
              _infoRow('${AppStrings.engine} :', data.engine),
              _infoRow('${AppStrings.externalPower} :', data.externalPower),
              _infoRow('${AppStrings.distance} :', data.distance),
              _infoRow('${AppStrings.todayKm} :', data.todayKm),
              CustomWidget.text(
                '${AppStrings.speed}: ${data.speed}',
                color: AppColors.whiteColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
        CustomPaint(
          size: Size(16.w, 8.h),
          painter: _TooltipArrowPainter(),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.sp,
            color: AppColors.whiteColor,
          ),
          children: [
            TextSpan(text: label),
            const TextSpan(text: ' '),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.mapOverlayColor;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
