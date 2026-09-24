import 'package:flutter/material.dart';
import 'package:gps_software/generated/assets.dart';

class DashboardLogoMark extends StatelessWidget {
  const DashboardLogoMark({
    super.key,
    required this.size,
  });
  final double size;
  static const Color brandBlue = Color(0xff174171);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.brandLogo,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
