import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';
import 'package:gps_software/util/app_constant.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      color: DashboardLogoMark.brandBlue,
      padding: EdgeInsets.only(
        top: topPadding + 18.h,
        left: 18.w,
        right: 18.w,
        bottom: 18.h,
      ),
      child: Row(
        children: [
          Icon(
            Icons.menu,
            color: AppColors.whiteColor,
            size: 32.w,
          ),
          SizedBox(width: 32.w),
          Expanded(
            child: CustomWidget.text(
              'GpsTrack Eye',
              color: AppColors.whiteColor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 16.w),
          Icon(
            Icons.notifications,
            color: AppColors.whiteColor,
            size: 29.w,
          ),
        ],
      ),
    );
  }
}

class DashboardProfileSummary extends StatelessWidget {
  const DashboardProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13.w, 6.h, 24.w, 16.h),
      child: Row(
        children: [
          DashboardLogoMark(size: 75.w),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidget.text(
                  'srisailogi',
                  color: const Color(0xff666666),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                CustomWidget.text(
                  'Version : 1.2.6',
                  color: const Color(0xff666666),
                  fontSize: 18,
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
