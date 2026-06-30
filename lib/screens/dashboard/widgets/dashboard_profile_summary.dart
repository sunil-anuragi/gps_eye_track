import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';

class DashboardProfileSummary extends StatelessWidget {
  const DashboardProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
      child: Row(
        children: [
          DashboardLogoMark(size: 45.w),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidget.text(
                  'srisailogi',
                  color: const Color(0xff666666),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                CustomWidget.text(
                  'Version : 1.2.6',
                  color: const Color(0xff666666),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
