import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/widget/tab_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/map/viewModel/map_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/map/widget/map_address_bar.dart';
import 'package:gps_software/screens/bottomBar/module/map/widget/map_floating_buttons.dart';
import 'package:gps_software/screens/bottomBar/module/map/widget/map_google_map_widget.dart';
import 'package:gps_software/screens/bottomBar/module/map/widget/map_refresh_overlay.dart';
import 'package:gps_software/util/app_constant.dart';

class MapView extends GetView<MapViewModel> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: TabAppBar(
        title: AppStrings.appTitle,
        action: IconButton(
          icon: Icon(Icons.refresh, color: AppColors.whiteColor, size: 22.r),
          onPressed: controller.onRefresh,
        ),
      ),
      body: const Stack(
        children: [
          MapGoogleMapWidget(),
          MapRefreshOverlay(),
          MapFloatingButtons(),
          MapAddressBar(),
        ],
      ),
    );
  }
}
