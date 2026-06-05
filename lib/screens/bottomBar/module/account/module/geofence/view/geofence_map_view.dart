import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_map_controls.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_map_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/module/geofence/widget/geofence_radius_panel.dart';
import 'package:gps_software/util/app_constant.dart';

class GeofenceMapView extends GetView<AccountViewModel> {
  static const geofenceMapView = '/geofenceMapView';

  const GeofenceMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const GeofenceAppBar(title: AppStrings.appTitle),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: const [
                GeofenceMapWidget(),
                GeofenceMapControls(),
              ],
            ),
          ),
          const GeofenceRadiusPanel(),
        ],
      ),
    );
  }
}
