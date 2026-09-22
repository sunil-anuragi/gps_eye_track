import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Number the user can set for a vehicle
enum VehicleSetting {
  odometer('Update Odometer', 'Odometer', 'Km', allowDecimal: true),
  overSpeed('Over Speed', 'Over speed limit', 'Km/h');

  const VehicleSetting(this.title, this.label, this.unit,
      {this.allowDecimal = false});

  final String title;
  final String label;
  final String unit;
  final bool allowDecimal;
}

/// Opens the "Update Odometer" / "Over Speed" popup and saves the value.
/// [currentValue] pre-fills the field, e.g. the vehicle's ODO or speed limit.
Future<void> showVehicleSettingDialog(
  VehicleSetting setting, {
  required String vehicleNo,
  String? currentValue,
}) async {
  final saved = await VehicleSettingStore.read(setting, vehicleNo);
  final value = await Get.dialog<double>(
    _VehicleValueDialog(
      setting: setting,
      initialValue: saved ?? _parseNumber(currentValue) ?? 0,
    ),
  );
  if (value == null) return;

  await VehicleSettingStore.write(setting, vehicleNo, value);
  Fluttertoast.showToast(
    msg: '${setting.label} set to ${_format(value)} ${setting.unit}',
    backgroundColor: TrackingColors.brandBlue,
    textColor: AppColors.whiteColor,
  );
}

/// "7744.08Km" → 7744.08
double? _parseNumber(String? text) {
  if (text == null) return null;
  final match = RegExp(r'[0-9]+(\.[0-9]+)?').firstMatch(text);
  return match == null ? null : double.tryParse(match.group(0)!);
}

String _format(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(2);

/// Keeps the values on the device.
/// Send them to the vehicle settings API when it is available.
class VehicleSettingStore {
  static String _key(VehicleSetting s, String vehicleNo) =>
      '${s.name}_$vehicleNo';

  static Future<double?> read(VehicleSetting s, String vehicleNo) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_key(s, vehicleNo));
  }

  static Future<void> write(
      VehicleSetting s, String vehicleNo, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key(s, vehicleNo), value);
  }
}

class _VehicleValueDialog extends StatefulWidget {
  const _VehicleValueDialog({
    required this.setting,
    required this.initialValue,
  });

  final VehicleSetting setting;
  final double initialValue;

  @override
  State<_VehicleValueDialog> createState() => _VehicleValueDialogState();
}

class _VehicleValueDialogState extends State<_VehicleValueDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: _format(widget.initialValue));
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = double.tryParse(_controller.text.trim());
    if (value == null || value < 0) {
      setState(
          () => _error = 'Enter a valid ${widget.setting.label.toLowerCase()}');
      return;
    }
    if (widget.setting == VehicleSetting.overSpeed && value == 0) {
      setState(() => _error = 'Speed limit must be more than 0');
      return;
    }
    Get.back(result: value);
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xffe8eef8);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    );

    return BadgeDialog(
      title: widget.setting.title,
      titleColor: Colors.black,
      titleSize: 18,
      backgroundColor: background,
      children: [
        SizedBox(height: 14.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.numberWithOptions(
                decimal: widget.setting.allowDecimal),
            inputFormatters: [
              FilteringTextInputFormatter.allow(widget.setting.allowDecimal
                  ? RegExp(r'^\d*\.?\d{0,2}')
                  : RegExp(r'^\d*')),
            ],
            onSubmitted: (_) => _submit(),
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Dmsans'),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whiteColor,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              suffixText: widget.setting.unit,
              suffixStyle: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xff6b6b6b),
                  fontFamily: 'Dmsans'),
              errorStyle: TextStyle(fontSize: 11.sp, fontFamily: 'Dmsans'),
              errorText: _error,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(child: badgeDialogButton('Cancel', Get.back)),
            SizedBox(width: 12.w),
            Expanded(child: badgeDialogButton('Submit', _submit)),
          ],
        ),
      ],
    );
  }
}
