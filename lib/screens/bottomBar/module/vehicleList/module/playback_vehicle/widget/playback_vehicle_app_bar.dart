import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class PlaybackVehicleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PlaybackVehicleAppBar({
    super.key,
    required this.title,
    required this.onDateTap,
  });

  final String title;
  final VoidCallback onDateTap;

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.playbackHeaderBg,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.whiteColor,
          size: 20.r,
        ),
        onPressed: () {
          Get.find<VehicleListViewModel>().stopPlayback();
          Get.back();
        },
      ),
      title: CustomWidget.text(
        title,
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.playbackTimerIcon,
            width: 22.r,
            height: 22.r,
            fit: BoxFit.contain,
          ),
          onPressed: onDateTap,
        ),
        SizedBox(width: 4.w),
      ],
    );
  }
}
