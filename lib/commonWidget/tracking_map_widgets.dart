import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

/// Shared colours for the live tracking & history screens
class TrackingColors {
  static const Color brandBlue = Color(0xff18548f);
  static const Color darkNavy = Color(0xff0c2440);
  static const Color divider = Color(0xffe3e6ea);
}

/// Blue app bar used by the tracking screens (optional subtitle line)
class TrackingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TrackingAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  final String title;
  final Widget? subtitle;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: TrackingColors.brandBlue,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: TrackingColors.brandBlue,
      elevation: 0,
      toolbarHeight: 56.h,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: 24.r),
        onPressed: Get.back,
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomWidget.text(
              title,
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              maxLine: 1,
            ),
          ),
          if (subtitle != null) subtitle!,
        ],
      ),
      actions: actions,
    );
  }
}

/// Round navy action button floating over the map
class MapCircleButton extends StatelessWidget {
  const MapCircleButton({
    super.key,
    this.icon,
    this.child,
    this.onTap,
    this.isActive = false,
    this.size = 48,
  });

  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;
  final bool isActive;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? TrackingColors.darkNavy : TrackingColors.brandBlue,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: Colors.black45,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size.r,
          height: size.r,
          child: Center(
            child: child ??
                Icon(icon, color: AppColors.whiteColor, size: (size * 0.5).r),
          ),
        ),
      ),
    );
  }
}

/// White square +/- zoom control
class MapZoomControls extends StatelessWidget {
  const MapZoomControls({super.key, required this.controller});

  final GoogleMapController? Function() controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(Icons.add, () {
            controller()?.animateCamera(CameraUpdate.zoomIn());
          }),
          Container(width: 30.r, height: 1, color: TrackingColors.divider),
          _button(Icons.remove, () {
            controller()?.animateCamera(CameraUpdate.zoomOut());
          }),
        ],
      ),
    );
  }

  Widget _button(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 40.r,
        height: 40.r,
        child: Icon(icon, color: Colors.black87, size: 26.r),
      ),
    );
  }
}

/// Bottom sheet for picking the map type
Future<void> showMapTypeSheet({
  required MapType current,
  required ValueChanged<MapType> onSelected,
}) {
  const options = {
    MapType.normal: ('Normal', Icons.map_outlined),
    MapType.satellite: ('Satellite', Icons.satellite_alt_outlined),
    MapType.terrain: ('Terrain', Icons.terrain_outlined),
    MapType.hybrid: ('Hybrid', Icons.layers_outlined),
  };

  return Get.bottomSheet(
    Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          CustomWidget.text(
            'Map Type',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          SizedBox(height: 14.h),
          Row(
            children: options.entries.map((e) {
              final selected = e.key == current;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    onSelected(e.key);
                    Get.back();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: selected
                          ? TrackingColors.brandBlue
                          : const Color(0xfff1f4f8),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          e.value.$2,
                          color: selected
                              ? AppColors.whiteColor
                              : TrackingColors.brandBlue,
                          size: 24.r,
                        ),
                        SizedBox(height: 6.h),
                        CustomWidget.text(
                          e.value.$1,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: selected
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

/// Parses the "lat,lng" / latitude+longitude fields passed from the menu
LatLng parseVehicleLatLng(Map<String, dynamic> vehicle, LatLng fallback) {
  if (vehicle['coordinate'] is String) {
    final parts = (vehicle['coordinate'] as String).split(',');
    if (parts.length == 2) {
      final lat = double.tryParse(parts[0].trim());
      final lng = double.tryParse(parts[1].trim());
      if (lat != null && lng != null) return LatLng(lat, lng);
    }
  }
  final lat = double.tryParse('${vehicle['latitude']}');
  final lng = double.tryParse('${vehicle['longitude']}');
  if (lat != null && lng != null) return LatLng(lat, lng);
  return fallback;
}

/// "truck" -> "Truck"
String capitalizeLabel(String value) => value.isEmpty
    ? value
    : value[0].toUpperCase() + value.substring(1).toLowerCase();
