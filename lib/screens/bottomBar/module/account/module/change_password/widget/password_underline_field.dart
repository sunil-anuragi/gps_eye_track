import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class PasswordUnderlineField extends StatelessWidget {
  const PasswordUnderlineField({
    super.key,
    required this.label,
    required this.controller,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  final String label;
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidget.text(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        8.h.sizeBoxFromHeight(),
        TextField(
          controller: controller,
          obscureText: !isVisible,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            color: AppColors.textFieldTextColor,
            letterSpacing: 2,
          ),
          decoration: InputDecoration(
            hintText: AuthStrings.passwordHint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              color: AppColors.grayColor,
              letterSpacing: 2,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grayColor,
                size: 20.r,
              ),
              onPressed: onToggleVisibility,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.blackColor),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.blackColor, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
      ],
    );
  }
}
