import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/settings/viewModel/setting_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Tone / notification preferences reached from the "Tone" settings row
class NotificationSettingView extends GetView<SettingViewModel> {
  static const notificationSettingView = '/notificationSettingView';

  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: const TrackingAppBar(title: 'Notification'),
      body: Container(
        color: AppColors.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => _SwitchRow(
                title: 'Receive notification',
                value: controller.receiveNotification.value,
                onChanged: controller.saveReceiveNotification,
              ),
            ),
            const _RowDivider(),
            Obx(
              () => _SwitchRow(
                title: 'Voice notification',
                value: controller.voiceNotification.value,
                onChanged: controller.saveVoiceNotification,
              ),
            ),
            const _RowDivider(),
            _ChevronRow(
              title: 'Alert option settings',
              onTap: () => Get.snackbar(
                'Alert option settings',
                'Coming soon',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(12.r),
                duration: const Duration(seconds: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 6.h, 10.w, 6.h),
      child: Row(
        children: [
          Expanded(
            child: CustomWidget.text(
              title,
              color: Colors.black,
              fontSize: 14.5,
              letterSpacing: 0,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.whiteColor,
            activeTrackColor: TrackingColors.brandBlue,
            inactiveThumbColor: AppColors.whiteColor,
            inactiveTrackColor: const Color(0xffe0e0e0),
            trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          ),
        ],
      ),
    );
  }
}

class _ChevronRow extends StatelessWidget {
  const _ChevronRow({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: Row(
          children: [
            Expanded(
              child: CustomWidget.text(
                title,
                color: Colors.black,
                fontSize: 14.5,
                letterSpacing: 0,
              ),
            ),
            Icon(Icons.chevron_right,
                color: const Color(0xff9a9a9a), size: 24.r),
          ],
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: const Color(0xffeaeaea));
}
