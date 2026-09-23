import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/vehicle_management/model/management_section.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:intl/intl.dart';

class ManagementColors {
  static const Color field = Color(0xffe4e4e4);
  static const Color hint = Color(0xff5c5c5c);
  static const Color button = TrackingColors.brandBlue;
  static const Color dialogButton = Color(0xff0055a0);
}

/// Grey rounded fields, "Last Update …" and a Save pill.
/// Dates are picked with a date picker; values are returned as strings
/// (dates in yyyy-MM-dd).
class ManagementForm extends StatefulWidget {
  const ManagementForm({
    super.key,
    required this.fields,
    required this.record,
    required this.onSave,
    this.buttonColor = ManagementColors.button,
    this.shrinkWrap = false,
  });

  final List<ManagementField> fields;
  final ManagementRecord record;
  final Future<void> Function(Map<String, String> values) onSave;
  final Color buttonColor;

  /// true inside dialogs (no scrolling of its own)
  final bool shrinkWrap;

  static final DateFormat storeFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat displayFormat = DateFormat('dd-MMM-yyyy');
  static final DateFormat lastUpdateFormat = DateFormat('ddMMMyyyy HH:mm');

  @override
  State<ManagementForm> createState() => _ManagementFormState();
}

class _ManagementFormState extends State<ManagementForm>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final Map<String, TextEditingController> _controllers = {
    for (final f in widget.fields) f.key: TextEditingController(),
  };
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _fill(widget.record);
  }

  @override
  void didUpdateWidget(covariant ManagementForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.record.lastUpdate != widget.record.lastUpdate) {
      _fill(widget.record);
    }
  }

  void _fill(ManagementRecord record) {
    for (final f in widget.fields) {
      final value = record.values[f.key] ?? '';
      _controllers[f.key]!.text = f.type == FieldType.date && value.isNotEmpty
          ? ManagementForm.displayFormat.format(DateTime.parse(value))
          : value;
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(ManagementField field) async {
    final controller = _controllers[field.key]!;
    DateTime initial = DateTime.now();
    if (controller.text.isNotEmpty) {
      initial = ManagementForm.displayFormat.parse(controller.text);
    }
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: TrackingColors.brandBlue,
            onPrimary: AppColors.whiteColor,
          ),
        ),
        child: child!,
      ),
    );
    if (date != null) {
      controller.text = ManagementForm.displayFormat.format(date);
    }
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final values = <String, String>{};
    for (final f in widget.fields) {
      final text = _controllers[f.key]!.text.trim();
      if (text.isEmpty) continue;
      values[f.key] = f.type == FieldType.date
          ? ManagementForm.storeFormat
              .format(ManagementForm.displayFormat.parse(text))
          : text;
    }

    final issue = values['issueDate'];
    final valid = values['validDate'];
    if (issue != null && valid != null && valid.compareTo(issue) < 0) {
      Fluttertoast.showToast(msg: 'Valid Date must be after Issue Date');
      return;
    }

    setState(() => _saving = true);
    await widget.onSave(values);
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final lastUpdate = widget.record.lastUpdate;
    final children = <Widget>[
      for (final field in widget.fields) ...[
        _buildField(field),
        SizedBox(height: 12.h),
      ],
      if (lastUpdate != null)
        Padding(
          padding: EdgeInsets.only(left: 8.w, top: 0, bottom: 4.h),
          child: CustomWidget.text(
            'Last Update ${ManagementForm.lastUpdateFormat.format(lastUpdate)}',
            fontSize: 12,
            letterSpacing: 0,
            color: const Color(0xff4f4f4f),
          ),
        ),
      SizedBox(height: 18.h),
      SizedBox(
        height: 44.h,
        child: ElevatedButton(
          onPressed: _saving ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            disabledBackgroundColor: widget.buttonColor.withValues(alpha: 0.6),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
          ),
          child: _saving
              ? SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.whiteColor),
                )
              : CustomWidget.text(
                  'Save',
                  color: AppColors.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
        ),
      ),
    ];

    if (widget.shrinkWrap) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 24.h),
      children: children,
    );
  }

  Widget _buildField(ManagementField field) {
    final isDate = field.type == FieldType.date;
    final isNumber = field.type == FieldType.number;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide.none,
    );

    return TextField(
      controller: _controllers[field.key],
      readOnly: isDate,
      onTap: isDate ? () => _pickDate(field) : null,
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))]
          : null,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        fontSize: 13.sp,
        color: Colors.black87,
        fontFamily: AppFonts.inter,
      ),
      decoration: InputDecoration(
        hintText: field.label,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: ManagementColors.hint,
          fontFamily: AppFonts.inter,
        ),
        labelText: null,
        isDense: true,
        filled: true,
        fillColor: ManagementColors.field,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide:
              const BorderSide(color: TrackingColors.brandBlue, width: 1.2),
        ),
        suffixIcon: isDate
            ? Icon(Icons.calendar_today_outlined,
                size: 16.r, color: ManagementColors.hint)
            : null,
      ),
    );
  }
}
