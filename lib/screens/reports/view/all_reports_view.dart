import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/reports/model/report_type.dart';
import 'package:gps_software/util/app_constant.dart';

class AllReportsView extends StatelessWidget {
  static const allReportsView = '/allReportsView';

  const AllReportsView({super.key});

  static const Color _background = Color(0xffeceff3);

  @override
  Widget build(BuildContext context) {
    final vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    final vehicleNo = vehicle['vehicleNo'] as String? ?? 'NL01AD8732';
    final vehicleType = vehicle['vehicleType'] as String? ?? 'truck';

    return Scaffold(
      backgroundColor: _background,
      appBar: TrackingAppBar(
        title: 'All Reports',
        subtitle: CustomWidget.text(
          '$vehicleNo | ${capitalizeLabel(vehicleType)}',
          color: AppColors.whiteColor,
          fontSize: 13,
          letterSpacing: 0,
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        itemCount: ReportType.values.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 26.w,
          mainAxisSpacing: 26.h,
          childAspectRatio: 1.45,
        ),
        itemBuilder: (_, index) =>
            _buildTile(ReportType.values[index], vehicle),
      ),
    );
  }

  Widget _buildTile(ReportType item, Map<String, dynamic> vehicle) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        item.route,
        arguments: {'reportType': item, 'vehicle': vehicle},
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(26.r),
          // Soft "neumorphic" shadow like the design
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(4, 6),
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              offset: Offset(-4, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                item.tileImage,
                height: 70,
                width: 70,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    Icon(item.icon, color: item.color, size: 32.r),
              ),
            ),
            SizedBox(height: 8.h),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomWidget.text(
                item.tileTitle,
                color: const Color(0xff555a60),
                fontSize: 12,
                letterSpacing: 0,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
