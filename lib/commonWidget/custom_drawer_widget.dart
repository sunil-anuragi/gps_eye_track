import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/alerts/view/alerts_view.dart';
import 'package:gps_software/screens/authentications/view/sign_in_view.dart';
import 'package:gps_software/screens/change_password/view/change_password_view.dart';
import 'package:gps_software/screens/geofence/view/geofence_view.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/user_details.dart';

/// Items of the home screen drawer
enum DrawerItem {
  home('Home'),
  setting('Setting'),
  notification('Notification'),
  changePassword('Change Password'),
  geofence('Geofence'),
  support('Support'),
  logout('Logout');

  const DrawerItem(this.title);

  final String title;
}

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key, this.selected = DrawerItem.home});

  /// Item highlighted when the drawer opens
  final DrawerItem selected;

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  static const Color _highlight = Color(0xff9fb3cf);
  static const Color _textColor = Color(0xff333333);

  late DrawerItem _selected = widget.selected;

  Future<void> _onTap(DrawerItem item) async {
    setState(() => _selected = item);
    // Let the highlight show before the drawer closes
    await Future.delayed(const Duration(milliseconds: 120));
    Get.back();

    switch (item) {
      case DrawerItem.home:
        break;
      case DrawerItem.notification:
        Get.toNamed(
          AlertsView.alertsView,
          arguments: {'vehicleNo': 'All Vehicles'},
        );
        break;
      case DrawerItem.logout:
        _confirmLogout();
        break;
      case DrawerItem.changePassword:
        Get.toNamed(ChangePasswordView.changePasswordView);
        break;
      case DrawerItem.geofence:
        Get.toNamed(GeofenceView.geofenceView);
        break;
      // Screens not built yet
      case DrawerItem.setting:
      case DrawerItem.support:
        Get.snackbar(
          item.title,
          'Coming soon',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(12.r),
          duration: const Duration(seconds: 2),
        );
        break;
    }
  }

  void _confirmLogout() {
    Get.dialog(const _LogoutDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Drawer(
        width: 0.76.sw,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final item in DrawerItem.values) _buildTile(item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: DashboardLogoMark.brandBlue,
      padding: EdgeInsets.fromLTRB(
        14.w,
        MediaQuery.of(context).padding.top + 18.h,
        14.w,
        18.h,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteColor.withValues(alpha: 0.25),
                width: 0.8,
              ),
            ),
            child: DashboardLogoMark(size: 54.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: CustomWidget.text(
              'GpsTrack Eye',
              color: Colors.black,
              fontSize: 17,
              letterSpacing: 0,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(DrawerItem item) {
    final selected = item == _selected;
    return Material(
      color: selected ? _highlight : Colors.transparent,
      child: InkWell(
        onTap: () => _onTap(item),
        child: SizedBox(
          height: 44.h,
          child: Row(
            children: [
              SizedBox(width: 10.w),
              SizedBox(
                width: 24.r,
                height: 24.r,
                child: _DrawerIcon(item),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomWidget.text(
                  item.title,
                  color: _textColor,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  maxLine: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Two-tone icons from the design, drawn from Material icons
class _DrawerIcon extends StatelessWidget {
  const _DrawerIcon(this.item);

  final DrawerItem item;

  @override
  Widget build(BuildContext context) {
    final size = 24.r;
    switch (item) {
      case DrawerItem.home:
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.home_outlined,
                color: const Color(0xffe8574f), size: size),
            Positioned(
              bottom: size * 0.14,
              child: Icon(Icons.grid_view_rounded,
                  color: const Color(0xff4a90e2), size: size * 0.38),
            ),
          ],
        );
      case DrawerItem.setting:
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.settings, color: const Color(0xff5b8fd0), size: size),
            Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: const BoxDecoration(
                color: Color(0xffdce8f7),
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      case DrawerItem.notification:
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.smartphone, color: const Color(0xff7b83c9), size: size),
            Positioned(
              bottom: size * 0.2,
              child: Icon(Icons.notifications,
                  color: const Color(0xfff9b52b), size: size * 0.58),
            ),
          ],
        );
      case DrawerItem.changePassword:
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.shield, color: const Color(0xff3f7fe0), size: size),
            Padding(
              padding: EdgeInsets.only(bottom: size * 0.05),
              child: Icon(Icons.lock,
                  color: const Color(0xfff9b52b), size: size * 0.45),
            ),
          ],
        );
      case DrawerItem.geofence:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff2f80d8),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.public,
                  color: const Color(0xff4caf50), size: size),
            ),
            Positioned(
              top: -size * 0.02,
              child: Icon(Icons.location_on,
                  color: const Color(0xffe53935), size: size * 0.6),
            ),
          ],
        );
      case DrawerItem.support:
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Icon(Icons.support_agent,
                color: const Color(0xff2d3a4a), size: size * 0.8),
            Positioned(
              left: 0,
              right: 0,
              bottom: size * 0.04,
              height: size * 0.24,
              child: Container(
                color: const Color(0xff8fc3f2),
                padding: EdgeInsets.symmetric(horizontal: size * 0.04),
                child: const FittedBox(
                  child: Text(
                    'SUPPORT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1f4f8a),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      case DrawerItem.logout:
        return Center(
          child: Container(
            width: size * 0.86,
            height: size * 0.86,
            decoration: BoxDecoration(
              color: const Color(0xffff4d57),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.4.r),
            ),
            child: Icon(Icons.power_settings_new,
                color: Colors.black, size: size * 0.6),
          ),
        );
    }
  }
}

/// "Logout" confirmation with CANCEL / CONFIRM
class _LogoutDialog extends StatefulWidget {
  const _LogoutDialog();

  @override
  State<_LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<_LogoutDialog> {
  bool _loading = false;

  Future<void> _logout() async {
    setState(() => _loading = true);
    await UserDetails().logoutUser();
    Get.offAllNamed(SignInView.signInView);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xfff1f1f1),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(26.w, 18.h, 26.w, 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.text(
              'Logout',
              color: Colors.black,
              fontSize: 22,
              letterSpacing: 0,
            ),
            SizedBox(height: 4.h),
            CustomWidget.text(
              'Are you sure you want to logout',
              color: Colors.black87,
              fontSize: 14,
              letterSpacing: 0.4,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(child: _button('CANCEL', Get.back)),
                SizedBox(width: 6.w),
                Expanded(
                  child: _button('CONFIRM', _loading ? null : _logout,
                      loading: _loading),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(String label, VoidCallback? onPressed,
          {bool loading = false}) =>
      SizedBox(
        height: 36.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: DashboardLogoMark.brandBlue,
            disabledBackgroundColor:
                DashboardLogoMark.brandBlue.withValues(alpha: 0.6),
            elevation: 3,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.r)),
          ),
          child: loading
              ? SizedBox(
                  width: 16.r,
                  height: 16.r,
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.whiteColor),
                )
              : CustomWidget.text(
                  label,
                  color: AppColors.whiteColor,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
        ),
      );
}
