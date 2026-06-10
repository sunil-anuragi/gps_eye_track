import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/commonWidget/report_date_selection_dialog_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackVehicleView extends GetView<VehicleListViewModel> {
  static const playbackVehicleView = '/playbackVehicleView';

  const PlaybackVehicleView({super.key});

  // Dummy playback info
  static const _dummySpeed = '1.0 Km/h';
  static const _dummyMileage = '1.64 Km';
  static const _dummyGpsTime = '2023-07-14 10:05:26';
  static const _dummyAddress =
      'C6/233 Bhagwan Shree Pashuram Rd, Block C, Yamuna Vihar, Shahdara, New Delhi , Delhi 110053, India';
  static const LatLng _dummyLatLng = LatLng(28.7041, 77.2650);

  @override
  Widget build(BuildContext context) {
    final RxString selectedSpeed = AppStrings.normal.obs;
    final RxBool isPlaying = false.obs;
    final RxString selectedDateRange = AppStrings.oneHrAgo.obs;

    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      if (vehicle == null) {
        return const Scaffold(body: SizedBox.shrink());
      }

      return Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: _buildAppBar(vehicle.vehicleId, selectedDateRange, context),
        body: Stack(
          children: [
            // ── Full-screen Map ────────────────────────────────────────
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _dummyLatLng,
                  zoom: 14,
                ),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                trafficEnabled: false,
              ),
            ),

            // ── Top Control Bar ────────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildControlBar(isPlaying, selectedSpeed, context),
            ),

            // ── Map Type Toggle (top-right) ────────────────────────────
            Positioned(
              top: 56.h,
              right: 10.w,
              child: _buildMapTypeButton(),
            ),

            // ── Playback Tooltip (center) ──────────────────────────────
            Positioned(
              top: MediaQuery.of(context).size.height * 0.28,
              left: 16.w,
              child: _buildPlaybackTooltip(),
            ),

            // ── Bottom Address Bar ─────────────────────────────────────
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                color: AppColors.mapOverlayColor,
                child: CustomWidget.text(
                  _dummyAddress,
                  color: AppColors.whiteColor,
                  fontSize: 11,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ── AppBar ─────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(
      String vehicleId, RxString selectedDateRange, BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon:
            Icon(Icons.arrow_back_ios, color: AppColors.whiteColor, size: 20.r),
        onPressed: () => Get.back(),
      ),
      title: CustomWidget.text(
        vehicleId,
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.access_time_rounded,
              color: AppColors.whiteColor, size: 22.r),
          onPressed: () => _showDateSelectionDialog(context, selectedDateRange),
        ),
      ],
    );
  }

  // ── Date Selection Dialog ──────────────────────────────────────────────────
  void _showDateSelectionDialog(
      BuildContext context, RxString selectedDateRange) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Obx(
        () => ReportDateSelectionDialogWidget(
          selectedDateRange: selectedDateRange.value,
          onSelectDate: (range) => selectedDateRange.value = range,
          onClose: () => Navigator.of(context).pop(),
          onOk: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  // ── Control Bar (below AppBar on map) ─────────────────────────────────────
  Widget _buildControlBar(
      RxBool isPlaying, RxString selectedSpeed, BuildContext context) {
    return Container(
      color: AppColors.darkBlack.withValues(alpha: 0.75),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Obx(() => Row(
            children: [
              // Play / Pause button
              GestureDetector(
                onTap: () => isPlaying.value = !isPlaying.value,
                child: Icon(
                  isPlaying.value
                      ? Icons.pause_circle_outline_rounded
                      : Icons.play_circle_outline_rounded,
                  color: AppColors.whiteColor,
                  size: 28.r,
                ),
              ),
              SizedBox(width: 12.w),
              // Vehicle icon
              Icon(Icons.directions_car_rounded,
                  color: AppColors.whiteColor, size: 22.r),

              const Spacer(),

              // Speed scale button  ⏩ 1X
              GestureDetector(
                onTap: () => _showSpeedScalePopup(context, selectedSpeed),
                child: Row(
                  children: [
                    Icon(Icons.fast_forward_rounded,
                        color: AppColors.whiteColor, size: 20.r),
                    SizedBox(width: 4.w),
                    CustomWidget.text(
                      _speedLabel(selectedSpeed.value),
                      color: AppColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // ── Map Type toggle button ─────────────────────────────────────────────────
  Widget _buildMapTypeButton() {
    return Container(
      width: 38.r,
      height: 38.r,
      decoration: BoxDecoration(
        color: AppColors.darkBlack.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(Icons.map_outlined, color: AppColors.whiteColor, size: 20.r),
    );
  }

  // ── Playback Tooltip (matches reference: speed, mileage, gps time) ─────────
  Widget _buildPlaybackTooltip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.mapOverlayColor,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tooltipRow('${AppStrings.speed} : ', _dummySpeed),
              SizedBox(height: 3.h),
              _tooltipRow('${AppStrings.mileage} : ', _dummyMileage),
              SizedBox(height: 3.h),
              _tooltipRow('${AppStrings.gpsTimeLabel} : ', _dummyGpsTime),
            ],
          ),
        ),
        // Arrow pointing down
        CustomPaint(
          size: Size(16.w, 8.h),
          painter: _ArrowPainter(),
        ),
      ],
    );
  }

  Widget _tooltipRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 11.sp,
          color: AppColors.whiteColor,
          fontFamily: 'Poppins',
        ),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ── Speed label helper ─────────────────────────────────────────────────────
  String _speedLabel(String speed) {
    switch (speed) {
      case 'Slow':
        return '0.5X';
      case 'Normal':
        return '1X';
      case 'Fast':
        return '2X';
      case 'Very Fast':
        return '4X';
      default:
        return '1X';
    }
  }

  // ── Speed Scale Popup (matches reference: radio list + Cancel/Ok) ──────────
  void _showSpeedScalePopup(BuildContext context, RxString selectedSpeed) {
    final options = [
      AppStrings.slow,
      AppStrings.normal,
      AppStrings.fastSpeed,
      AppStrings.veryFast,
    ];

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 80.h),
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Center(
                  child: CustomWidget.text(
                    AppStrings.setPlayBackTime,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(height: 1, color: AppColors.borderGrayColor),
                // Radio options
                Obx(() => Column(
                      children: options.map((option) {
                        final isSelected = selectedSpeed.value == option;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => selectedSpeed.value = option,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 4.h),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: option,
                                      groupValue: selectedSpeed.value,
                                      activeColor: AppColors.blackColor,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (val) {
                                        if (val != null) {
                                          selectedSpeed.value = val;
                                        }
                                      },
                                    ),
                                    CustomWidget.text(
                                      option,
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                                height: 1, color: AppColors.borderGrayColor),
                          ],
                        );
                      }).toList(),
                    )),
                SizedBox(height: 12.h),
                // Cancel / Ok buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _dialogButton(
                          label: AppStrings.cancel,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _dialogButton(
                          label: AppStrings.ok,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: CustomWidget.text(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

// ── Arrow painter for tooltip ──────────────────────────────────────────────
class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.mapOverlayColor;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
