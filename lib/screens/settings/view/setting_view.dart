import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/settings/view/language_view.dart';
import 'package:gps_software/screens/settings/view/notification_setting_view.dart';
import 'package:gps_software/screens/settings/viewModel/setting_view_model.dart';
import 'package:gps_software/screens/settings/widgets/setting_dialogs.dart';
import 'package:gps_software/screens/settings/widgets/setting_icons.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:share_plus/share_plus.dart';

class SettingView extends GetView<SettingViewModel> {
  static const settingView = '/settingView';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const TrackingAppBar(title: 'Setting'),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        children: [
          _SettingRow(
            icon: SettingIcon.language,
            title: 'Language',
            subtitle: 'Change Language',
            onTap: () => Get.toNamed(LanguageView.languageView),
          ),
          _SettingRow(
            icon: SettingIcon.tone,
            title: 'Tone',
            subtitle: 'Change tone and Notification',
            onTap: () =>
                Get.toNamed(NotificationSettingView.notificationSettingView),
          ),
          _SettingRow(
            icon: SettingIcon.mapType,
            title: 'Map Type',
            subtitle: 'Select Default Map type',
            onTap: () => showMapTypeDialog(controller),
          ),
          _SettingRow(
            icon: SettingIcon.refresh,
            title: 'Select Auto Refresh Time',
            subtitle: 'Set auto refresh Time',
            onTap: () => showRefreshTimeDialog(controller),
          ),
          _SettingRow(
            icon: SettingIcon.changeScreen,
            title: 'Change Screen',
            subtitle: 'Startup Screen when application launch',
            onTap: () => showStartupScreenDialog(controller),
          ),
          _SettingRow(
            icon: SettingIcon.motion,
            title: 'Vehicle Motion',
            subtitle: 'Select vehicle moving motion type',
            onTap: () => showVehicleMotionDialog(controller),
          ),
          _SettingRow(
            icon: SettingIcon.share,
            title: 'Share Application',
            subtitle: "Share Application's Play store Link",
            onTap: _shareApp,
          ),
        ],
      ),
    );
  }

  void _shareApp() {
    Share.share(
      'Track your vehicles with GpsTrack Eye: '
      'https://play.google.com/store/apps/details?id=com.gps.software',
      subject: 'GpsTrack Eye',
    );
  }
}

/// Icon + bold title + grey subtitle + chevron
class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final SettingIcon icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
        child: Row(
          children: [
            SizedBox(
              width: 38.r,
              child: Center(child: settingIcon(icon, size: 30.r)),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWidget.text(
                    title,
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  CustomWidget.text(
                    subtitle,
                    color: const Color(0xff6f6f6f),
                    fontSize: 12,
                    letterSpacing: 0,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: const Color(0xff8a8a8a),
              size: 24.r,
            ),
          ],
        ),
      ),
    );
  }
}
