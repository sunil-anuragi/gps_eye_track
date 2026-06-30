import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class DashboardLogoMark extends StatelessWidget {
  const DashboardLogoMark({
    super.key,
    required this.size,
    this.showTitle = true,
  });
  final double size;
  final bool showTitle;
  static const Color brandBlue = Color(0xff18548f);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: brandBlue,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 0.785398,
            child: Container(
              width: size * 0.26,
              height: size * 0.26,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.whiteColor,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Transform.rotate(
                angle: -0.785398,
                child: Icon(
                  Icons.gps_fixed,
                  color: AppColors.whiteColor,
                  size: size * 0.19,
                ),
              ),
            ),
          ),
          if (showTitle) ...[
            SizedBox(height: size * 0.12),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomWidget.text(
                'GpsTrack Eye',
                color: AppColors.whiteColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
