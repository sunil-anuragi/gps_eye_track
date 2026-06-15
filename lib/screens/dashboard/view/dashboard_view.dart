import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_header.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_status_card.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_vehicle_chart.dart';
import 'package:gps_software/util/app_constant.dart';

class DashboardView extends StatelessWidget {
  static const dashboardView = '/dashboardView';

  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: DashboardLogoMark.brandBlue,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            DashboardHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DashboardProfileSummary(),
                    DashboardVehicleChart(),
                    DashboardStatusGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
