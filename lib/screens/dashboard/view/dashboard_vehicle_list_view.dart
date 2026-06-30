import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/dashboard/widgets/dashboard_logo_mark.dart';
import 'package:gps_software/screens/dashboard/widgets/vehicle_card.dart';
import 'package:gps_software/util/app_constant.dart';

class DashboardVehicleListView extends StatelessWidget {
  static const dashboardVehicleListView = '/dashboardVehicleListView';

  const DashboardVehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock list of vehicles matching the screenshot
    final vehicles = List.generate(
      5,
      (index) => {
        'vehicleNo': AppStrings.sampleVehicleName,
        'vehicleType': 'car',
        'todayKm': '87.08KM',
        'speed': '30.0 km/h',
        'status': 'Running (0 Min, 0 Sec )',
        'lastUpdate': '07-Jul-2023 05:19:45 PM',
        'odo': '7744.08Km',
        'expiryDate': 'Nov 09,2023',
        'isExpired': true,
        'speedLimit': '60',
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xfff3f6f9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: DashboardLogoMark.brandBlue,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: DashboardLogoMark.brandBlue,
        elevation: 0,
        toolbarHeight: 56.h,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: 24.w,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomWidget.text(
          'Dashboard',
          color: AppColors.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackColor,
                  fontFamily: 'Dmsans',
                ),
                decoration: InputDecoration(
                  hintText: 'Search..',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 18.w, right: 10.w),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                      size: 22.r,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40.w,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
          
          // Scrollable Vehicle List
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              padding: EdgeInsets.only(bottom: 80.h),
              itemBuilder: (context, index) {
                final v = vehicles[index];
                return VehicleCard(
                  vehicleNo: v['vehicleNo'] as String,
                  vehicleType: v['vehicleType'] as String,
                  todayKm: v['todayKm'] as String,
                  speed: v['speed'] as String,
                  status: v['status'] as String,
                  lastUpdate: v['lastUpdate'] as String,
                  odo: v['odo'] as String,
                  expiryDate: v['expiryDate'] as String,
                  isExpired: v['isExpired'] as bool,
                  speedLimit: v['speedLimit'] as String,
                  onLoadAddress: () {
                    Get.snackbar(
                      'Address',
                      'Loading address for ${v['vehicleNo']}...',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xff18548f),
                      colorText: AppColors.whiteColor,
                      duration: const Duration(seconds: 2),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar(
            'Map',
            'Opening map view...',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xff18548f),
            colorText: AppColors.whiteColor,
          );
        },
        backgroundColor: AppColors.whiteColor,
        shape: CircleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 1.r),
        ),
        elevation: 4,
        child: Icon(
          Icons.map_outlined,
          color: const Color(0xff18548f),
          size: 26.r,
        ),
      ),
    );
  }
}
