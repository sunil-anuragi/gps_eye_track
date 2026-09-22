import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/history/model/history_point.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:intl/intl.dart';

/// Period picker: 1 hr ago / Today / Yesterday / User-defined.
/// Used by the history and report screens.
class HistoryFilterDialog extends StatefulWidget {
  const HistoryFilterDialog({
    super.key,
    required this.initialPeriod,
    required this.onApply,
    this.title = 'History',
    this.initialFrom,
    this.initialTo,
  });

  final String title;
  final HistoryPeriod initialPeriod;
  final DateTime? initialFrom;
  final DateTime? initialTo;
  final void Function(HistoryPeriod period, DateTime? from, DateTime? to)
      onApply;

  @override
  State<HistoryFilterDialog> createState() => _HistoryFilterDialogState();
}

class _HistoryFilterDialogState extends State<HistoryFilterDialog> {
  final DateFormat _format = DateFormat('dd-MMM-yyyy hh:mm a');

  late HistoryPeriod _period;
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    _period = widget.initialPeriod;
    if (_period == HistoryPeriod.userDefined) {
      _from = widget.initialFrom;
      _to = widget.initialTo;
    }
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(now) ? now : initial,
      firstDate: now.subtract(const Duration(days: 90)),
      lastDate: now,
      builder: _pickerTheme,
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: _pickerTheme,
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: TrackingColors.brandBlue,
          onPrimary: AppColors.whiteColor,
        ),
      ),
      child: child!,
    );
  }

  Future<void> _selectUserDefined() async {
    setState(() => _period = HistoryPeriod.userDefined);
    final now = DateTime.now();
    final from =
        await _pickDateTime(_from ?? DateTime(now.year, now.month, now.day));
    if (from == null) return;
    final to =
        await _pickDateTime(_to != null && _to!.isAfter(from) ? _to! : now);
    if (to == null) return;
    if (!to.isAfter(from)) {
      Fluttertoast.showToast(msg: 'End time must be after start time');
      return;
    }
    setState(() {
      _from = from;
      _to = to;
    });
  }

  void _submit() {
    if (_period == HistoryPeriod.userDefined &&
        (_from == null || _to == null)) {
      _selectUserDefined();
      return;
    }
    Get.back();
    widget.onApply(_period, _from, _to);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            color: TrackingColors.brandBlue,
            padding: EdgeInsets.fromLTRB(18.w, 4.h, 4.w, 4.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomWidget.text(
                    widget.title,
                    color: AppColors.whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: Icon(Icons.close,
                      color: AppColors.whiteColor, size: 22.r),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 18.h, 14.w, 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _periodButton(HistoryPeriod.oneHourAgo),
                    SizedBox(width: 12.w),
                    _periodButton(HistoryPeriod.today),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    _periodButton(HistoryPeriod.yesterday),
                    SizedBox(width: 12.w),
                    _periodButton(HistoryPeriod.userDefined),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: _period == HistoryPeriod.userDefined &&
                          _from != null &&
                          _to != null
                      ? _buildRangeSummary()
                      : const SizedBox(width: double.infinity),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 42.h,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TrackingColors.brandBlue,
                      foregroundColor: AppColors.whiteColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: CustomWidget.text(
                      'OK',
                      color: AppColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _periodButton(HistoryPeriod period) {
    final selected = _period == period;
    return Expanded(
      child: GestureDetector(
        onTap: period == HistoryPeriod.userDefined
            ? _selectUserDefined
            : () => setState(() => _period = period),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 38.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                selected ? TrackingColors.darkNavy : TrackingColors.brandBlue,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: selected ? 0.3 : 0.15),
                blurRadius: selected ? 6 : 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomWidget.text(
            period.label,
            color: AppColors.whiteColor,
            fontSize: 12.5,
            letterSpacing: 0,
            maxLine: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildRangeSummary() {
    return GestureDetector(
      onTap: _selectUserDefined,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xffeef3f9),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: TrackingColors.brandBlue.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.date_range, color: TrackingColors.brandBlue, size: 20.r),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWidget.text('From : ${_format.format(_from!)}',
                      fontSize: 12, letterSpacing: 0),
                  SizedBox(height: 2.h),
                  CustomWidget.text('To     : ${_format.format(_to!)}',
                      fontSize: 12, letterSpacing: 0),
                ],
              ),
            ),
            Icon(Icons.edit, color: TrackingColors.brandBlue, size: 16.r),
          ],
        ),
      ),
    );
  }
}
