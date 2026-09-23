import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/enum/map_type.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/settings/viewModel/setting_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Navy pill used as an option row inside the settings dialogs.
/// Selected options use the darker navy, matching the history filter chips.
Widget _optionButton({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return SizedBox(
    height: 42.h,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selected ? TrackingColors.darkNavy : TrackingColors.brandBlue,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: CustomWidget.text(
        label,
        color: AppColors.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
    ),
  );
}

/// Cancel / Ok pair sitting at the bottom of a settings dialog
Widget _cancelOkRow(VoidCallback onOk) {
  return Row(
    children: [
      Expanded(
        child: badgeDialogButton('Cancel', Get.back, radius: 24, height: 40),
      ),
      SizedBox(width: 14.w),
      Expanded(
        child: badgeDialogButton('Ok', onOk, radius: 24, height: 40),
      ),
    ],
  );
}

// --------------------------------------------------------------- map type

/// Map type picker: 2x2 grid of previews with a green ring on the selection
Future<void> showMapTypeDialog(SettingViewModel controller) async {
  var selected = controller.mapType.value;
  await Get.dialog<void>(
    StatefulBuilder(
      builder: (context, setState) => Dialog(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        insetPadding: EdgeInsets.symmetric(horizontal: 26.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 16.h),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1,
                children: [
                  for (final type in MapTypeEnum.values)
                    _MapTypeTile(
                      type: type,
                      selected: selected == type,
                      onTap: () => setState(() => selected = type),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: _barButton('Cancel', Get.back)),
                SizedBox(width: 4.w),
                Expanded(
                  child: _barButton('Ok', () {
                    Get.back();
                    controller.saveMapType(selected);
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Flat navy bar button filling the bottom edge of the map type dialog
Widget _barButton(String label, VoidCallback onTap) {
  return Material(
    color: TrackingColors.brandBlue,
    child: InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 46.h,
        child: Center(
          child: CustomWidget.text(
            label,
            color: AppColors.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
    ),
  );
}

class _MapTypeTile extends StatelessWidget {
  const _MapTypeTile({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final MapTypeEnum type;
  final bool selected;
  final VoidCallback onTap;

  String get _asset => switch (type) {
        MapTypeEnum.Normal => Assets.mapTypeRoad,
        MapTypeEnum.Satellite => Assets.mapTypeSatellite,
        MapTypeEnum.Hybrid => Assets.mapTypeHybrid,
        MapTypeEnum.Terrain => Assets.mapTypeTerrain,
      };

  /// The design labels the satellite tile "Setellite"
  String get _label => switch (type) {
        MapTypeEnum.Normal => 'Road Map',
        MapTypeEnum.Satellite => 'Setellite',
        MapTypeEnum.Hybrid => 'Hybrid',
        MapTypeEnum.Terrain => 'Terrain',
      };

  /// Hybrid and satellite previews are dark, so their label flips to white
  bool get _dark => type == MapTypeEnum.Hybrid || type == MapTypeEnum.Satellite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? const Color(0xff22c55e) : Colors.transparent,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(_asset, fit: BoxFit.cover),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: CustomWidget.text(
                    _label,
                    color: _dark ? AppColors.whiteColor : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------- refresh time

/// "Set Refresh Time": one pill per interval, the current one highlighted
Future<void> showRefreshTimeDialog(SettingViewModel controller) async {
  var selected = controller.refreshSeconds.value;
  await Get.dialog<void>(
    StatefulBuilder(
      builder: (context, setState) => BadgeDialog(
        title: 'Set Refresh Time',
        titleColor: Colors.black,
        horizontalInset: 26,
        children: [
          badgeDialogSubtitle('Select Default Refresh time for application'),
          SizedBox(height: 14.h),
          for (final seconds in kRefreshOptions) ...[
            _optionButton(
              label: '$seconds Second',
              selected: selected == seconds,
              onTap: () => setState(() => selected = seconds),
            ),
            SizedBox(height: 10.h),
          ],
          SizedBox(height: 4.h),
          _cancelOkRow(() {
            Get.back();
            controller.saveRefreshSeconds(selected);
          }),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------- vehicle motion

/// Slow / Jump motion picker, with the car badge overlapping the card
Future<void> showVehicleMotionDialog(SettingViewModel controller) async {
  var selected = controller.motion.value;
  await Get.dialog<void>(
    StatefulBuilder(
      builder: (context, setState) => BadgeDialog(
        title: '',
        horizontalInset: 26,
        badge: Image.asset(
          Assets.settingIcMotionBadge,
          width: 58.r,
          height: 58.r,
          fit: BoxFit.contain,
        ),
        children: [
          for (final value in VehicleMotion.values) ...[
            _optionButton(
              label: value.label,
              selected: selected == value,
              onTap: () => setState(() => selected = value),
            ),
            SizedBox(height: 10.h),
          ],
          SizedBox(height: 8.h),
          _cancelOkRow(() {
            Get.back();
            controller.saveMotion(selected);
          }),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------- startup screen

/// Which screen the app opens on
Future<void> showStartupScreenDialog(SettingViewModel controller) async {
  var selected = controller.startupScreen.value;
  await Get.dialog<void>(
    StatefulBuilder(
      builder: (context, setState) => BadgeDialog(
        title: 'Change Screen',
        titleColor: Colors.black,
        horizontalInset: 26,
        children: [
          badgeDialogSubtitle('Startup Screen when application launch'),
          SizedBox(height: 14.h),
          for (final value in StartupScreen.values) ...[
            _optionButton(
              label: value.label,
              selected: selected == value,
              onTap: () => setState(() => selected = value),
            ),
            SizedBox(height: 10.h),
          ],
          SizedBox(height: 4.h),
          _cancelOkRow(() {
            Get.back();
            controller.saveStartupScreen(selected);
          }),
        ],
      ),
    ),
  );
}
