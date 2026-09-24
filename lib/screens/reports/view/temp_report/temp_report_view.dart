import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Temperature readings: date + location, with ignition, temperature and
/// speed stacked on the navy panel
class TempReportView extends GetView<ReportViewModel> {
  const TempReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      itemBuilder: (context, item, index) =>
          _TempCard(item: item as TempReportItem),
    );
  }
}

class _TempCard extends StatelessWidget {
  const _TempCard({required this.item});

  final TempReportItem item;

  @override
  Widget build(BuildContext context) {
    return ReportCard(
      sidePanelWidth: 86,
      sidePanel: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _panelPair(
              label: 'Ignition ${item.ignitionOn ? 'On' : 'Off'}',
              value: ReportViewModel.timeFormat.format(item.time),
            ),
            SizedBox(height: 4.h),
            _panelPair(
              label: 'Temp',
              value: '${item.temperature.toStringAsFixed(1)}°C',
            ),
            SizedBox(height: 4.h),
            _panelPair(
              label: 'Speed',
              value: '${item.speed.toStringAsFixed(0)} Km',
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(22.w, 12.h, 10.w, 10.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ReportIconText(
                asset: Assets.reportCardCalendar,
                text: ReportViewModel.dayFormat.format(item.time),
                fontSize: 14,
              ),
            ),
          ),
          const ReportDivider(),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 14.h),
            child: Row(
              children: [
                Image.asset(Assets.reportCardLocation,
                    width: 26.r, height: 26.r, fit: BoxFit.contain),
                SizedBox(width: 12.w),
                Expanded(child: ReportAddress(item.location)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Bold label with its value underneath
  Widget _panelPair({required String label, required String value}) => Column(
        children: [
          CustomWidget.text(
            label,
            color: AppColors.whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          CustomWidget.text(
            value,
            color: AppColors.whiteColor,
            fontSize: 12,
            letterSpacing: 0,
          ),
        ],
      );
}
