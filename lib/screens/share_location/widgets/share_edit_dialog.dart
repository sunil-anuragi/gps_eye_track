import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/badge_dialog.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/share_location/model/location_share.dart';
import 'package:gps_software/screens/share_location/viewModel/share_location_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// "Share Name / Valid Till / Save" popup. Returns the edited share.
class ShareEditDialog extends StatefulWidget {
  const ShareEditDialog({
    super.key,
    required this.vehicleNo,
    required this.share,
  });

  final String vehicleNo;
  final LocationShare share;

  @override
  State<ShareEditDialog> createState() => _ShareEditDialogState();
}

class _ShareEditDialogState extends State<ShareEditDialog> {
  late final TextEditingController _name =
      TextEditingController(text: widget.share.name);
  late DateTime _validTill = widget.share.validTill;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Widget _pickerTheme(BuildContext context, Widget? child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: TrackingColors.brandBlue,
            onPrimary: AppColors.whiteColor,
          ),
        ),
        child: child!,
      );

  Future<void> _pickValidTill() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _validTill.isBefore(now) ? now : _validTill,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: _pickerTheme,
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_validTill),
      builder: _pickerTheme,
    );
    if (time == null) return;
    setState(() => _validTill =
        DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  void _save() {
    final name = _name.text.trim();
    Get.back(
      result: widget.share.copyWith(
        name: name.isEmpty ? widget.vehicleNo : name,
        validTill: _validTill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BadgeDialog(
      title: widget.vehicleNo,
      titleColor: Colors.black,
      horizontalInset: 32,
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _row(
                child: Row(
                  children: [
                    Icon(Icons.person, color: AppColors.whiteColor, size: 18.r),
                    SizedBox(width: 10.w),
                    _label('Share Name'),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: _name,
                        textAlign: TextAlign.end,
                        cursorColor: AppColors.whiteColor,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 13.sp,
                          fontFamily: AppFonts.inter,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: _pickValidTill,
                child: _row(
                  child: Row(
                    children: [
                      SizedBox(width: 28.w),
                      _label('Valid Till'),
                      const Spacer(),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: _label(ShareLocationViewModel.validFormat
                            .format(_validTill)),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.chevron_right,
                          color: AppColors.whiteColor, size: 18.r),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              badgeDialogButton('Save', _save),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row({required Widget child}) => Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: TrackingColors.brandBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: child,
      );

  Widget _label(String text) => CustomWidget.text(
        text,
        color: AppColors.whiteColor,
        fontSize: 13,
        letterSpacing: 0,
        maxLine: 1,
      );
}
