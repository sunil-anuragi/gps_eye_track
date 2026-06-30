import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/custom_drawer_widget.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/dashboard/viewModel/dashboard_view_model.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_profile_summary.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_status_card.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_vehicle_chart.dart';
import 'package:gps_software/util/app_constant.dart';

class DashboardView extends GetView<DashboardViewModel> {
  static const dashboardView = '/dashboardView';

  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: DashboardLogoMark.brandBlue,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: DashboardLogoMark.brandBlue,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColors.whiteColor,
                size: 24.w,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: CustomWidget.text(
          'GpsTrack Eye',
          color: AppColors.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.whiteColor,
              size: 24.w,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 12.w),
        ],
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 56.h,
      ),
      drawer: const CustomDrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  DashboardProfileSummary(),
                  DashboardVehicleChart(),
                  SizedBox(height: 20),
                  DashboardStatusGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
