import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeofenceAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.action,
  });

  final String title;
  final bool showBack;
  final Widget? action;

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
                size: 20.r,
              ),
              onPressed: () => Get.back(),
            )
          : null,
      title: CustomWidget.text(
        title,
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        if (action != null) action!,
        SizedBox(width: 8.w),
      ],
    );
  }
}
