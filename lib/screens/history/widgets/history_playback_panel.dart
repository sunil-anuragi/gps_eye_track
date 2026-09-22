import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/history/viewModel/history_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Bottom panel of the history screen: current position, time, speed,
/// play/pause and the draggable progress track.
class HistoryPlaybackPanel extends GetView<HistoryViewModel> {
  const HistoryPlaybackPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 12.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Obx(() {
        final point = controller.currentPoint;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Location
            Container(
              color: TrackingColors.brandBlue,
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
              constraints: BoxConstraints(minHeight: 56.h),
              child: Row(
                children: [
                  Icon(Icons.person_pin_circle_outlined,
                      color: AppColors.whiteColor, size: 28.r),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomWidget.text(
                      point == null
                          ? 'Select a period to view history'
                          : 'Lat ${point.position.latitude.toStringAsFixed(5)}, '
                              'Lng ${point.position.longitude.toStringAsFixed(5)}',
                      color: AppColors.whiteColor,
                      fontSize: 13,
                      letterSpacing: 0,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Details + play button
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 10.w, 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month,
                                color: const Color(0xff4a4a4a), size: 24.r),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    CustomWidget.text(
                                      point == null
                                          ? '--'
                                          : controller.displayFormat
                                              .format(point.time),
                                      fontSize: 13,
                                      letterSpacing: 0,
                                    ),
                                    SizedBox(width: 14.w),
                                    CustomWidget.text('Speed',
                                        fontSize: 13, letterSpacing: 0),
                                    Container(
                                      width: 8.r,
                                      height: 8.r,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      decoration: BoxDecoration(
                                        color: (point?.speed ?? 0) > 0
                                            ? AppColors.runningColor
                                            : AppColors.blackColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    CustomWidget.text(
                                      '${(point?.speed ?? 0).toStringAsFixed(1)} Km/H',
                                      fontSize: 13,
                                      letterSpacing: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(Icons.directions_car,
                                color: const Color(0xff4a4a4a), size: 24.r),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomWidget.text(
                                controller.title,
                                fontSize: 13,
                                letterSpacing: 0,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _buildPlayButton(),
                ],
              ),
            ),

            // Progress track
            Container(
              color: TrackingColors.brandBlue,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _buildProgressTrack(),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPlayButton() {
    final playing = controller.isPlaying.value;
    return Material(
      color: TrackingColors.brandBlue,
      shape: const CircleBorder(),
      elevation: 6,
      shadowColor: Colors.black54,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: controller.togglePlay,
        child: SizedBox(
          width: 60.r,
          height: 60.r,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              playing ? Icons.pause : Icons.play_arrow,
              key: ValueKey(playing),
              color: AppColors.whiteColor,
              size: 34.r,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressTrack() {
    return LayoutBuilder(builder: (context, constraints) {
      final carWidth = 56.w;
      final trackWidth = constraints.maxWidth - carWidth;
      final left = trackWidth * controller.progress;

      void seek(double dx) =>
          controller.seekTo((dx - carWidth / 2) / trackWidth);

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => seek(d.localPosition.dx),
        onHorizontalDragStart: (_) => controller.pause(),
        onHorizontalDragUpdate: (d) => seek(d.localPosition.dx),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Full track
            Positioned(
              left: carWidth / 2,
              right: carWidth / 2,
              child: Container(height: 2, color: const Color(0xff0e3a66)),
            ),
            // Travelled part
            Positioned(
              left: carWidth / 2,
              width: left,
              child: Container(height: 2, color: const Color(0xff22e02a)),
            ),
            // Car thumb
            Positioned(
              left: left,
              child: Icon(
                Icons.directions_car_filled,
                color: const Color(0xff2dbd2d),
                size: carWidth,
              ),
            ),
          ],
        ),
      );
    });
  }
}
