import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceCircularButton extends StatelessWidget {
  const GeofenceCircularButton({
    super.key,
    required this.icon,
    this.label,
    this.color = AppColors.primaryColor,
    this.onTap,
    this.size = 44,
  });

  final IconData icon;
  final String? label;
  final Color color;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 20.r),
            if (label != null) ...[
              2.h.sizeBoxFromHeight(),
              CustomWidget.text(
                label!,
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
