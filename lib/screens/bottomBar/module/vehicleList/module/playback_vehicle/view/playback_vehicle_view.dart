import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/report_date_selection_dialog_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/widget/playback_address_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/widget/playback_control_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/widget/playback_map_controls.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/widget/playback_map_widget.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/widget/playback_speed_scale_dialog.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/module/playback_vehicle/widget/playback_vehicle_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackVehicleView extends GetView<VehicleListViewModel> {
  static const playbackVehicleView = '/playbackVehicleView';

  const PlaybackVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDateRange = AppStrings.oneHrAgo.obs;

    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      if (vehicle == null) {
        return const Scaffold(body: SizedBox.shrink());
      }

      return PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) controller.stopPlayback();
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: PlaybackVehicleAppBar(
            title: AppStrings.appTitle,
            onDateTap: () => _showDateSelectionDialog(
              context,
              selectedDateRange,
            ),
          ),
          body: Column(
            children: [
              PlaybackControlBar(
                onSpeedTap: () => Get.dialog(
                  const PlaybackSpeedScaleDialog(),
                  barrierDismissible: true,
                ),
              ),
              Expanded(
                child: Stack(
                  children: const [
                    PlaybackMapWidget(),
                    PlaybackMapControls(),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: PlaybackAddressBar(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showDateSelectionDialog(
    BuildContext context,
    RxString selectedDateRange,
  ) {
    Get.dialog(
      Obx(
        () => ReportDateSelectionDialogWidget(
          selectedDateRange: selectedDateRange.value,
          onSelectDate: (range) => selectedDateRange.value = range,
          onClose: () => Get.back(),
          onOk: () => Get.back(),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
