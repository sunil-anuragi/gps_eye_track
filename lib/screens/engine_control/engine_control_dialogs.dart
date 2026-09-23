import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/user_details.dart';

enum EngineCommand { stop, start }

extension on EngineCommand {
  String get label =>
      this == EngineCommand.stop ? 'Stop Engine' : 'Start Engine';
}

/// Engine flow: pick Stop/Start → confirm with the login password.
Future<void> showEngineControl(String vehicleNo) async {
  final command = await Get.dialog<EngineCommand>(
    _EngineCommandDialog(vehicleNo: vehicleNo),
    barrierDismissible: true,
  );
  if (command == null) return;

  final confirmed = await Get.dialog<bool>(
    _EnginePasswordDialog(vehicleNo: vehicleNo, command: command),
    barrierDismissible: false,
  );
  if (confirmed == true) {
    Fluttertoast.showToast(
      msg: '${command.label} command sent to $vehicleNo',
      backgroundColor: TrackingColors.brandBlue,
      textColor: AppColors.whiteColor,
    );
  }
}

/// Car-with-key illustration shown in the badge of both engine popups
class _EngineBadge extends StatelessWidget {
  const _EngineBadge();

  @override
  Widget build(BuildContext context) {
    final size = 96.r;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.directions_car,
              color: const Color(0xfff0717a), size: 46.r),
          Positioned(
            top: size * 0.2,
            right: size * 0.26,
            child:
                Icon(Icons.vpn_key, color: const Color(0xff2d3a4a), size: 19.r),
          ),
          Positioned(
            top: size * 0.26,
            left: size * 0.22,
            child: Icon(Icons.auto_awesome,
                color: const Color(0xfff5c518), size: 13.r),
          ),
        ],
      ),
    );
  }
}

class _EngineCommandDialog extends StatelessWidget {
  const _EngineCommandDialog({required this.vehicleNo});

  final String vehicleNo;

  @override
  Widget build(BuildContext context) {
    return BadgeDialog(
      title: vehicleNo,
      badge: const _EngineBadge(),
      children: [
        SizedBox(height: 4.h),
        CustomWidget.text(
          'Login Password is Required*',
          color: const Color(0xff6b6b6b),
          fontSize: 12.5,
          letterSpacing: 0,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              badgeDialogButton(EngineCommand.stop.label,
                  () => Get.back(result: EngineCommand.stop)),
              SizedBox(height: 10.h),
              badgeDialogButton(EngineCommand.start.label,
                  () => Get.back(result: EngineCommand.start)),
              SizedBox(height: 16.h),
              badgeDialogButton('Cancel', Get.back, radius: 30),
            ],
          ),
        ),
      ],
    );
  }
}

class _EnginePasswordDialog extends StatefulWidget {
  const _EnginePasswordDialog({required this.vehicleNo, required this.command});

  final String vehicleNo;
  final EngineCommand command;

  @override
  State<_EnginePasswordDialog> createState() => _EnginePasswordDialogState();
}

class _EnginePasswordDialogState extends State<_EnginePasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Please enter your password');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });

    // Checks against the saved login password when one is stored.
    // Send the engine command API request from here.
    final saved = await UserDetails().getReloginCredentials;
    if (!mounted) return;
    if (saved != null && saved['password'] != password) {
      setState(() {
        _loading = false;
        _error = 'Incorrect password';
      });
      return;
    }
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: TrackingColors.brandBlue, width: 1.2),
    );

    return BadgeDialog(
      title: widget.vehicleNo,
      badge: const _EngineBadge(),
      children: [
        SizedBox(height: 4.h),
        CustomWidget.text(
          'Please enter your password',
          color: const Color(0xff6b6b6b),
          fontSize: 12.5,
          letterSpacing: 0,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscure,
            autofocus: true,
            onSubmitted: (_) => _confirm(),
            style: TextStyle(fontSize: 14.sp, fontFamily: AppFonts.inter),
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
              hintStyle: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xff7a7a7a),
                fontFamily: AppFonts.inter,
              ),
              errorText: _error,
              errorStyle:
                  TextStyle(fontSize: 11.sp, fontFamily: AppFonts.inter),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: const BorderSide(
                    color: TrackingColors.brandBlue, width: 1.8),
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 18.r,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: badgeDialogButton('Confirm', _confirm, loading: _loading),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: badgeDialogButton('Cancel', () => Get.back(result: false)),
            ),
          ],
        ),
      ],
    );
  }
}
