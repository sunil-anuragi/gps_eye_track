import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/reports/model/report_items.dart';
import 'package:gps_software/screens/reports/viewModel/report_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class ReportColors {
  static const Color background = Color(0xffe8eef8);
  static const Color strip = Color(0xffdfe4ea);
  static const Color panel = Color(0xff173f70);
  static const Color divider = Color(0xff9e9e9e);
  static const Color startDot = Color(0xff0f9d58);
  static const Color endDot = Color(0xffef2d2d);
  static const Color text = Color(0xff2b2b2b);
  static const Color greyText = Color(0xff7a7a7a);
}

/// Page shell used by every report list: app bar with download + calendar,
/// optional "Total Distance" strip, loading / empty states.
class ReportScaffold extends GetView<ReportViewModel> {
  const ReportScaffold({
    super.key,
    required this.itemBuilder,
    this.showTotalDistance = false,
    this.floatingActionButton,
    this.itemSpacing = 14,
  });

  final Widget Function(BuildContext context, Object item, int index)
      itemBuilder;
  final bool showTotalDistance;
  final Widget? floatingActionButton;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReportColors.background,
      appBar: ReportAppBar(
        title: controller.reportType.screenTitle,
        subtitle: controller.vehicleTitle,
        showActions: true,
      ),
      floatingActionButton: floatingActionButton,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: ReportColors.panel),
          );
        }
        final items = controller.items;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showTotalDistance && controller.hasLoaded.value)
              Container(
                color: ReportColors.strip,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: CustomWidget.text(
                  'Total Distance : ${controller.totalDistanceKm.toStringAsFixed(2)}KM',
                  fontSize: 13,
                  letterSpacing: 0,
                ),
              ),
            Expanded(
              child: items.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      color: ReportColors.panel,
                      onRefresh: controller.loadReport,
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 90.h),
                        itemCount: items.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: itemSpacing.h),
                        itemBuilder: (context, index) =>
                            itemBuilder(context, items[index], index),
                      ),
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEmpty() {
    final loaded = controller.hasLoaded.value;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(controller.reportType.icon,
              size: 64.r, color: Colors.grey.shade400),
          SizedBox(height: 12.h),
          CustomWidget.text(
            loaded
                ? 'No records found for the selected date'
                : 'Select a date to view the report',
            color: ReportColors.greyText,
            fontSize: 14,
            letterSpacing: 0,
          ),
          SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: controller.openDateDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: ReportColors.panel,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            icon: const Icon(Icons.calendar_month),
            label: const Text('Select Date'),
          ),
        ],
      ),
    );
  }
}

/// Blue report app bar: bold upper-case title, vehicle subtitle and
/// optional download + calendar actions.
class ReportAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReportAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showActions = false,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final bool showActions;

  /// Custom actions, used when [showActions] is false
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ReportColors.panel,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: ReportColors.panel,
      elevation: 0,
      toolbarHeight: 56.h,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: 24.r),
        onPressed: Get.back,
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomWidget.text(
              title,
              color: AppColors.whiteColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              maxLine: 1,
            ),
          ),
          if (subtitle != null)
            CustomWidget.text(
              subtitle!,
              color: AppColors.whiteColor,
              fontSize: 11,
              letterSpacing: 0,
              maxLine: 1,
            ),
        ],
      ),
      actions: showActions
          ? [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Get.find<ReportViewModel>().downloadReport(),
                icon: Icon(Icons.snippet_folder,
                    color: AppColors.whiteColor, size: 24.r),
              ),
              SizedBox(width: 12.w),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Get.find<ReportViewModel>().openDateDialog(),
                icon: Icon(Icons.calendar_month,
                    color: AppColors.whiteColor, size: 24.r),
              ),
              SizedBox(width: 14.w),
            ]
          : actions,
    );
  }
}

/// White rounded card with an optional navy panel on the right
class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.child,
    this.sidePanel,
    this.sidePanelWidth = 82,
    this.onTap,
    this.elevated = false,
  });

  final Widget child;
  final Widget? sidePanel;
  final double sidePanelWidth;
  final VoidCallback? onTap;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: elevated ? 0.18 : 0.05),
              blurRadius: elevated ? 8 : 4,
              offset: Offset(0, elevated ? 4 : 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: child),
              if (sidePanel != null)
                Container(
                  width: sidePanelWidth.w,
                  color: ReportColors.panel,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                  alignment: Alignment.center,
                  child: sidePanel,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "217.85 / Km" block for the navy side panel
class ReportPanelValue extends StatelessWidget {
  const ReportPanelValue({super.key, required this.value, required this.unit});

  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          CustomWidget.text(value,
              color: AppColors.whiteColor, fontSize: 13, letterSpacing: 0),
          SizedBox(height: 2.h),
          CustomWidget.text(unit,
              color: AppColors.whiteColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0),
        ],
      ),
    );
  }
}

/// Start / End time block for the navy side panel
class ReportPanelTimes extends StatelessWidget {
  const ReportPanelTimes({
    super.key,
    required this.start,
    required this.end,
    this.startLabel = 'Start Time',
    this.endLabel = 'End Time',
  });

  final DateTime start;
  final DateTime end;
  final String startLabel;
  final String endLabel;

  @override
  Widget build(BuildContext context) {
    Widget block(DateTime time, String label) => Column(
          children: [
            CustomWidget.text(ReportViewModel.timeFormat.format(time),
                color: AppColors.whiteColor, fontSize: 12, letterSpacing: 0),
            CustomWidget.text(label,
                color: AppColors.whiteColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0),
          ],
        );

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          block(start, startLabel),
          SizedBox(height: 6.h),
          block(end, endLabel),
        ],
      ),
    );
  }
}

/// Icon + text row. Pass either a material [icon] or an image [asset].
class ReportIconText extends StatelessWidget {
  const ReportIconText({
    super.key,
    this.icon,
    this.asset,
    required this.text,
    this.iconColor = const Color(0xff9aa6b2),
    this.fontSize = 13,
    this.textColor = ReportColors.text,
  }) : assert((icon == null) != (asset == null),
            'Provide exactly one of icon or asset');

  final IconData? icon;
  final String? asset;
  final String text;
  final Color iconColor;
  final double fontSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (asset != null)
          Image.asset(asset!, width: 20.r, height: 20.r, fit: BoxFit.contain)
        else
          Icon(icon, color: iconColor, size: 20.r),
        SizedBox(width: 8.w),
        Flexible(
          child: CustomWidget.text(
            text,
            color: textColor,
            fontSize: fontSize,
            letterSpacing: 0,
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Two-line address text
class ReportAddress extends StatelessWidget {
  const ReportAddress(
    this.location, {
    super.key,
    this.color = ReportColors.text,
  });

  final ReportLocation location;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomWidget.text(
      location.address,
      color: color,
      fontSize: 11,
      letterSpacing: 0,
      maxLine: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Green → red dots joined by a line, with an address beside each dot
class ReportRouteTimeline extends StatelessWidget {
  const ReportRouteTimeline({
    super.key,
    required this.from,
    required this.to,
    this.textColor = ReportColors.text,
    this.lineColor = ReportColors.text,
    this.startTime,
    this.endTime,
  });

  final ReportLocation from;
  final ReportLocation to;
  final Color textColor;
  final Color lineColor;
  final String? startTime;
  final String? endTime;

  @override
  Widget build(BuildContext context) {
    Widget time(String? t) => t == null
        ? const SizedBox.shrink()
        : SizedBox(
            width: 68.w,
            child: CustomWidget.text(t,
                color: textColor, fontSize: 13, letterSpacing: 0),
          );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [time(startTime), time(endTime)],
          ),
          SizedBox(
            width: 22.w,
            child: Column(
              children: [
                SizedBox(height: 8.h),
                _dot(ReportColors.startDot),
                Expanded(child: Container(width: 1.5, color: lineColor)),
                _dot(ReportColors.endDot),
                SizedBox(height: 8.h),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReportAddress(from, color: textColor),
                SizedBox(height: 10.h),
                ReportAddress(to, color: textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) => Container(
        width: 12.r,
        height: 12.r,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

/// Round "map" bubble used to open the map of a report
class ReportMapFab extends StatelessWidget {
  const ReportMapFab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 58.r,
        height: 58.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [Color(0xffe9fbff), Color(0xff9fe3f5)],
          ),
          border: Border.all(color: AppColors.whiteColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(Assets.reportCardLocation,
              width: 32.r, height: 32.r, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

/// Divider used inside report cards
class ReportDivider extends StatelessWidget {
  const ReportDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: ReportColors.divider);
}
