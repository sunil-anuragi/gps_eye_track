import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

/// "Create Geofence" popup. Returns the entered name, or null on cancel.
Future<String?> showCreateGeofenceDialog({String? initialName}) {
  return Get.dialog<String>(_CreateGeofenceDialog(initialName: initialName));
}

class _CreateGeofenceDialog extends StatefulWidget {
  const _CreateGeofenceDialog({this.initialName});

  final String? initialName;

  @override
  State<_CreateGeofenceDialog> createState() => _CreateGeofenceDialogState();
}

class _CreateGeofenceDialogState extends State<_CreateGeofenceDialog> {
  late final TextEditingController _name =
      TextEditingController(text: widget.initialName);
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Please enter a name');
      return;
    }
    Get.back(result: name);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide.none,
    );

    return Dialog(
      backgroundColor: TrackingColors.brandBlue,
      insetPadding: EdgeInsets.symmetric(horizontal: 34.w),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: CustomWidget.text(
              widget.initialName == null ? 'Create Geofence' : 'Edit Geofence',
              color: AppColors.whiteColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.fromLTRB(22.w, 16.h, 22.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: TextField(
                    controller: _name,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    onSubmitted: (_) => _save(),
                    style:
                        TextStyle(fontSize: 14.sp, fontFamily: AppFonts.inter),
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff7a7a7a),
                        fontFamily: AppFonts.inter,
                      ),
                      errorText: _error,
                      errorStyle: TextStyle(
                          fontSize: 11.sp, fontFamily: AppFonts.inter),
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xffdedede),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(child: _button('Cancel', Get.back)),
                    SizedBox(width: 26.w),
                    Expanded(child: _button('Save', _save)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 34.h),
        ],
      ),
    );
  }

  Widget _button(String label, VoidCallback onPressed) => SizedBox(
        height: 38.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: TrackingColors.brandBlue,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
          ),
          child: CustomWidget.text(
            label,
            color: AppColors.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
      );
}
