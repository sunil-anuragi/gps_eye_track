import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'commonWidget/animations/bouncing_widget.dart';

class CustomWidget {
  ///
  /// This method is used for show heading text in ui with some prebuild properties
  ///
  static Text text(
    String text, {
    Color color = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 16.0,
    double letterSpacing = 0.5,
    double wordSpacing = 0,
    TextAlign textAlign = TextAlign.start,
    int? maxLine,
    TextOverflow? overflow,
    TextDecoration decoration = TextDecoration.none,
    String? fontFamily,
    Color? decorationColor,
  }) {
    return Text(
      text.tr,
      textAlign: textAlign,
      maxLines: maxLine,
      style: TextStyle(
          // fontFamily: fontFamily ?? null,
          fontFamily: 'Poppins',
          decoration: decoration,
          color: color,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          decorationColor: decorationColor,
          overflow: overflow),
    );
  }

  static customAssetImageWidget(
      {required String image,
      required double height,
      required double width,
      BoxFit fit = BoxFit.contain,
      Color? color}) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        image,
        fit: fit,
        color: color,
      ),
    );
  }

  static Widget customButton(
      {required VoidCallback? callBack,
      double height = 48,
      double width = 339,
      required String btnText,
      double borderRadius = 12.0,
      FontWeight fontWeight = FontWeight.w600,
      Color? color,
      Color textColor = AppColors.whiteColor,
      Color borderColor = Colors.transparent,
      bool isLoading = false,
      double textSize = 16.0}) {
    return BouncingWidget(
      onTap: callBack,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Center(
                child: text(btnText,
                    fontSize: textSize.sp,
                    letterSpacing: 0.5,
                    fontWeight: fontWeight,
                    color: textColor),
              ),
      ),
    );
  }

  ///
  /// This method provide [BoxDecoration] with some predefine properties
  ///
  static BoxDecoration customBoxDecoration({
    Color color = Colors.white,
    Color boxBorderColor = Colors.transparent,
    double borderRadius = 10.0,
    BoxShadow? boxShadow,
    bool isBoxShadow = false,
    double borderWidth = 1,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
      border: Border.all(color: boxBorderColor, width: borderWidth),
      boxShadow: isBoxShadow ? [boxShadow!] : [],
    );
  }

  ///
  /// Custom Input Decoration it's used all over the app for TextField
  ///
  static TextFormField customTextFormField({
    required String hintText,
    required String labelText,
    String? Function(String?)? validator,
    String? Function(String?)? onChange,
    String? Function(String?)? onSubmit,
    bool isSufixShow = false,
    bool isReadOnly = false,
    bool isPrefixShow = false,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    int? maxLength,
    int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    required TextEditingController controller,
    Color? borderColor,
    Function? onTap,
  }) {
    return TextFormField(
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
      onTap: () => onTap == null ? () {} : onTap(),
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      readOnly: isReadOnly,
      maxLines: maxLines,
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      cursorColor: AppColors.blackColor,
      style: TextStyle(
          fontSize: 14.0.sp,
          letterSpacing: 0.5,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: AppColors.textFieldTextColor),
      decoration: InputDecoration(
        isDense: true,
        prefixIconConstraints: BoxConstraints(
          minWidth: 20.w,
        ),
        suffixIcon: isSufixShow
            ? Padding(
                padding: const EdgeInsets.only(right: 10, left: 20),
                child: suffixIcon,
              )
            : text(''),
        prefixIcon: isPrefixShow
            ? prefixIcon
            : Padding(
                padding: const EdgeInsetsDirectional.only(start: 0.0),
                child: text(''),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.borderGrayColor,
            width: 0,
          ),
        ),
        labelText: labelText.tr,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            fontSize: 12.0.sp,
            letterSpacing: 0.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor),
        hintText: hintText.tr,
        hintStyle: TextStyle(
            fontSize: 14.0.sp,
            letterSpacing: 0.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: AppColors.grayColor),
        contentPadding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.h),
      ),
    );
  }

  static DropdownSearch customDropDownTextField<T>({
    bool enableSearch = true,
    Function(T?)? onChange,
    T? value,
    String? hintText,
    required List<T> items,
    required String Function(T)? itemAsString,
  }) {
    return DropdownSearch<T>(
      selectedItem: value,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
            fontSize: 14.0.sp,
            letterSpacing: 0.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: AppColors.textFieldTextColor),
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          hintStyle: TextStyle(
              fontSize: 14.0.sp,
              letterSpacing: 0.5,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: AppColors.grayColor),
          labelStyle: TextStyle(
              fontSize: 12.0.sp,
              letterSpacing: 0.5,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor),
        ),
      ),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        menuProps: const MenuProps(backgroundColor: Colors.white),
        showSearchBox: enableSearch,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search".tr,
            prefixIconConstraints: BoxConstraints(
              minWidth: 20.w,
            ),
            contentPadding: EdgeInsets.zero,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 12.0.w, left: 12.w),
              child: Image.asset(
                Assets.assetsSearch,
              ),
            ),
          ),
        ),
      ),
      // showSelectedItems: true,
      items: items,
      onChanged: onChange,
      itemAsString: itemAsString,
    );
  }

  static Widget noDataWidget() {
    return Center(
      child: CustomWidget.text("Data Not Found...",
          color: AppColors.iconGrayColor,
          fontSize: 20,
          fontWeight: FontWeight.w600),
    );
  }

  static dynamic dateRangePickerDialog({
    DateTime? maxDate,
    DateTime? minDate,
    required Function(PickerDateRange v) onSubmit,
  }) {
    return Get.dialog(Dialog(
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 0.5.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.whiteColor,
        ),
        // padding:  EdgeInsets.symmetric(vertical: 10.r ,horizontal: 10.r),
        child: SfDateRangePicker(
          maxDate: maxDate ?? DateTime.now(),
          minDate:
              minDate ?? DateTime.now().subtract(const Duration(days: 365)),
          headerHeight: 60.h,
          selectionRadius: 20,
          headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: AppColors.datePickerHeaderColor),
          showActionButtons: true,
          view: DateRangePickerView.month,
          todayHighlightColor: AppColors.blackColor,
          selectionTextStyle: const TextStyle(color: AppColors.blackColor),
          // selectionColor: Colors.blue,
          startRangeSelectionColor: AppColors.datePickerHeaderColor,
          endRangeSelectionColor: AppColors.datePickerHeaderColor,
          rangeTextStyle: const TextStyle(color: AppColors.blackColor),
          selectionMode: DateRangePickerSelectionMode.range,

          onSubmit: (Object? value) {
            if (value is PickerDateRange) {
              onSubmit(value);
            }
          },
          onCancel: () {
            Get.back();
          },
        ),
      ),
    ));
  }

  static dynamic datePickerDialog({
    required Function(DateTime v) onSubmit,
    DateTime? minDate,
    DateTime? maxDate,
    bool enablePastDates = true,
  }) async {
    return Get.dialog(Dialog(
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 0.5.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.whiteColor,
        ),
        // padding:  EdgeInsets.symmetric(vertical: 10.r ,horizontal: 10.r),
        child: SfDateRangePicker(
          headerHeight: 60.h,
          selectionRadius: 20,
          headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: AppColors.datePickerHeaderColor),
          showActionButtons: true,
          view: DateRangePickerView.month,
          minDate: minDate,
          enablePastDates: enablePastDates,
          maxDate: maxDate,
          todayHighlightColor: AppColors.blackColor,
          selectionTextStyle: const TextStyle(color: AppColors.blackColor),
          selectionColor: AppColors.primaryColor.withOpacity(0.12),
          startRangeSelectionColor: AppColors.datePickerHeaderColor,
          endRangeSelectionColor: AppColors.datePickerHeaderColor,
          rangeTextStyle: const TextStyle(color: AppColors.blackColor),
          selectionMode: DateRangePickerSelectionMode.single,
          onSubmit: (Object? value) {
            if (value is DateTime) {
              final DateTime selectedDate = value;
              onSubmit(selectedDate);
            }
          },
          onCancel: () {
            Get.back();
          },
        ),
      ),
    ));
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(2015, 8),
    //   lastDate: DateTime(2101),
    //   builder: (context, child) {
    //     return Theme(
    //       data: Theme.of(context).copyWith(
    //         colorScheme: const ColorScheme.light(
    //           primary:
    //               AppColors.datePickerHeaderColor, // header background color
    //           onPrimary: AppColors.primaryColor, // header text color
    //           onSurface: Colors.black, // body text color
    //         ),
    //         datePickerTheme: const DatePickerThemeData(
    //             todayBorder:
    //                 BorderSide(color: AppColors.primaryColor, width: 1.5),
    //             backgroundColor: AppColors.borderGrayColor,
    //             headerBackgroundColor: AppColors.datePickerHeaderColor),
    //         textButtonTheme: TextButtonThemeData(
    //           style: TextButton.styleFrom(
    //             foregroundColor: AppColors.primaryColor, // button text color
    //           ),
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );
    //
    // if (picked != null) {
    //   return picked;
    // }
  }

  Future<BitmapDescriptor> getMarkerBitmap(int size, {String? text}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data =
        await img.toByteData(format: ui.ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  static Widget customLoadingButton({
    double height = 48,
    double width = 339,
    double borderRadius = 12.0,
    Color? color,
    Color borderColor = Colors.transparent,
  }) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: Center(child: customLoader()),
    );
  }

  static Widget customLoader(
      {Color color = AppColors.whiteColor,
      double height = 20,
      double width = 20}) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );
  }

  static Widget customLinearProgressBar() {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      backgroundColor: Colors.grey.withOpacity(0.5),
    );
  }
}
