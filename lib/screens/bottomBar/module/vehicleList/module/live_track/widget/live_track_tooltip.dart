import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class LiveTrackTooltip extends StatelessWidget {
  const LiveTrackTooltip({
    super.key,
    required this.info,
  });

  final LiveTrackVehicleInfo info;

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
                '${info.vehicleId}(${info.vehicleCode})',
                color: AppColors.whiteColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              4.h.sizeBoxFromHeight(),
              _infoRow('${AppStrings.timeLabel} :', info.time),
              _infoRow('${AppStrings.status} :', info.status),
              _infoRow('${AppStrings.engine} :', info.engine),
              _infoRow('${AppStrings.externalPower} :', info.externalPower),
              _infoRow('${AppStrings.distance} :', info.distance),
              _infoRow('${AppStrings.todayKm} :', info.todayKm),
              CustomWidget.text(
                '${AppStrings.speed}: ${info.speed}',
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
