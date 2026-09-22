import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceReportView extends GetView<ReportViewModel> {
  const GeofenceReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemSpacing: 12,
      itemBuilder: (context, item, index) =>
          GeofenceReportCard(item: item as GeofenceReportItem),
    );
  }
}

/// Navy block with a round icon on the left, event details on the right
class GeofenceReportCard extends StatelessWidget {
  const GeofenceReportCard({super.key, required this.item});

  final GeofenceReportItem item;

  @override
  Widget build(BuildContext context) {
    final eventColor =
        item.isEnter ? ReportColors.startDot : ReportColors.endDot;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
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
              child: Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Icon(Icons.share_location,
                    color: ReportColors.startDot, size: 28.r),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 14.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomWidget.text(
                            item.vehicleNo,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: eventColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: CustomWidget.text(
                            '${item.isEnter ? 'IN' : 'OUT'} · ${item.fenceName}',
                            color: eventColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const ReportDivider(),
                    ),
                    CustomWidget.text(
                      ReportViewModel.fullFormat.format(item.time),
                      color: ReportColors.greyText,
                      fontSize: 12.5,
                      letterSpacing: 0,
                    ),
                    SizedBox(height: 6.h),
                    ReportAddress(item.location),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
