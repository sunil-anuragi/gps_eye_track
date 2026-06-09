import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/generated/assets.dart';

class VehicleReportAppBarActions extends StatelessWidget {
  const VehicleReportAppBarActions({
    super.key,
    required this.onDownload,
    required this.onCalendar,
  });

  final VoidCallback onDownload;
  final VoidCallback onCalendar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Image.asset(
            Assets.reportDownloadIcon,
            width: 22.r,
            height: 22.r,
            fit: BoxFit.contain,
          ),
          onPressed: onDownload,
        ),
        IconButton(
          icon: Image.asset(
            Assets.reportCalendarIcon,
            width: 20.r,
            height: 20.r,
            fit: BoxFit.contain,
          ),
          onPressed: onCalendar,
        ),
      ],
    );
  }
}
