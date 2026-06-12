import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceCircularButton extends StatelessWidget {
  const GeofenceCircularButton({
    super.key,
    this.icon,
    this.iconAsset,
    this.label,
    this.color = AppColors.primaryColor,
    this.onTap,
    this.size = 44,
    this.iconSize,
  }) : assert(icon != null || iconAsset != null);

  final IconData? icon;
  final String? iconAsset;
  final String? label;
  final Color color;
  final VoidCallback? onTap;
  final double size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final assetSize = iconSize ?? size * 0.55;

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
            if (iconAsset != null)
              Image.asset(
                iconAsset!,
                width: assetSize.r,
                height: assetSize.r,
                fit: BoxFit.contain,
              )
            else
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
