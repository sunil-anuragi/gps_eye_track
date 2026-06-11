import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackControlBar extends StatefulWidget {
  const PlaybackControlBar({
    super.key,
    required this.onSpeedTap,
  });

  final VoidCallback onSpeedTap;

  @override
  State<PlaybackControlBar> createState() => _PlaybackControlBarState();
}

class _PlaybackControlBarState extends State<PlaybackControlBar> {
  ui.Image? _carThumbImage;

  @override
  void initState() {
    super.initState();
    _loadCarThumbImage();
  }

  Future<void> _loadCarThumbImage() async {
    final data = await rootBundle.load(Assets.playbackCarIcon);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 48,
    );
    final frame = await codec.getNextFrame();
    if (mounted) {
      setState(() => _carThumbImage = frame.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VehicleListViewModel>();

    return Container(
      color: AppColors.mapOverlayColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Obx(
        () {
          final total = VehicleListViewModel.playbackRoute.length - 1;
          final current = controller.playbackCurrentIndex.value;
          final progress = total > 0 ? current / total : 0.0;

          return Row(
            children: [
              GestureDetector(
                onTap: controller.togglePlayback,
                child: Icon(
                  controller.playbackIsPlaying.value
                      ? Icons.pause_circle_outline_rounded
                      : Icons.play_circle_outline_rounded,
                  color: AppColors.whiteColor,
                  size: 30.r,
                ),
              ),
              12.w.sizeBoxFromWidth(),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 1.h,
                    activeTrackColor: AppColors.whiteColor,
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape: _CarThumbShape(
                      size: 28.r,
                      carImage: _carThumbImage,
                    ),
                  ),
                  child: Slider(
                    value: progress.clamp(0.0, 1.0),
                    onChanged: total > 0
                        ? (value) => controller.onPlaybackSeek(
                              (value * total).round(),
                            )
                        : null,
                  ),
                ),
              ),
              8.w.sizeBoxFromWidth(),
              GestureDetector(
                onTap: widget.onSpeedTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.playbackForwardIcon,
                      width: 22.r,
                      height: 22.r,
                      fit: BoxFit.contain,
                    ),
                    4.w.sizeBoxFromWidth(),
                    CustomWidget.text(
                      controller.playbackSpeedLabel,
                      color: AppColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CarThumbShape extends SliderComponentShape {
  const _CarThumbShape({
    required this.size,
    required this.carImage,
  });

  final double size;
  final ui.Image? carImage;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(size, size);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    if (carImage != null) {
      paintImage(
        canvas: context.canvas,
        rect: Rect.fromCenter(
          center: center,
          width: size,
          height: size,
        ),
        image: carImage!,
        fit: BoxFit.contain,
      );
      return;
    }

    final iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: String.fromCharCode(Icons.directions_car_rounded.codePoint),
        style: TextStyle(
          fontSize: size * 0.55,
          fontFamily: Icons.directions_car_rounded.fontFamily,
          package: Icons.directions_car_rounded.fontPackage,
          color: AppColors.playbackRouteColor,
        ),
      ),
    )..layout();

    iconPainter.paint(
      context.canvas,
      center - Offset(iconPainter.width / 2, iconPainter.height / 2),
    );
  }
}
