import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

/// White rounded dialog card with a bold grey title. When [badge] is given it
/// sits in a white circle overlapping the card's top edge.
/// Used by the engine, near-by and parking popups.
class BadgeDialog extends StatelessWidget {
  const BadgeDialog({
    super.key,
    required this.title,
    required this.children,
    this.badge,
    this.titleSize = 18,
    this.horizontalInset = 32,
    this.backgroundColor = AppColors.whiteColor,
    this.titleColor = const Color(0xff4f4f4f),
  });

  final String title;
  final List<Widget> children;
  final Widget? badge;
  final double titleSize;
  final double horizontalInset;
  final Color backgroundColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    final badgeSize = 96.r;
    final card = Container(
      margin: EdgeInsets.only(top: badge != null ? badgeSize * 0.6 : 0),
      padding: EdgeInsets.fromLTRB(
        16.w,
        badge != null ? badgeSize * 0.48 : 20.h,
        16.w,
        18.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomWidget.text(
            title,
            color: titleColor,
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            textAlign: TextAlign.center,
          ),
          ...children,
        ],
      ),
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: horizontalInset.w),
      child: badge == null
          ? card
          : Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                card,
                Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(child: badge),
                ),
              ],
            ),
    );
  }
}

/// Grey subtitle line under a [BadgeDialog] title
Widget badgeDialogSubtitle(String text, {double fontSize = 12.5}) {
  return Padding(
    padding: EdgeInsets.only(top: 4.h),
    child: CustomWidget.text(
      text,
      color: const Color(0xff6b6b6b),
      fontSize: fontSize,
      letterSpacing: 0,
      textAlign: TextAlign.center,
    ),
  );
}

/// Solid navy dialog button
Widget badgeDialogButton(
  String label,
  VoidCallback onPressed, {
  double radius = 10,
  double height = 42,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w600,
  bool loading = false,
}) {
  return SizedBox(
    height: height.h,
    child: ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: TrackingColors.brandBlue,
        disabledBackgroundColor:
            TrackingColors.brandBlue.withValues(alpha: 0.6),
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
      child: loading
          ? SizedBox(
              width: 18.r,
              height: 18.r,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.whiteColor,
              ),
            )
          : CustomWidget.text(
              label,
              color: AppColors.whiteColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: 0,
            ),
    ),
  );
}
