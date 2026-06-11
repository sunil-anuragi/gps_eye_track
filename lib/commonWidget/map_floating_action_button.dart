import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapFloatingActionButton extends StatelessWidget {
  const MapFloatingActionButton({
    super.key,
    required this.iconAsset,
    this.onTap,
    this.iconSize = 28,
  });

  final String iconAsset;
  final VoidCallback? onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        iconAsset,
        width: iconSize.r,
        height: iconSize.r,
        fit: BoxFit.fill,
      ),
    );
  }
}
