import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

class DashboardStatusGrid extends StatelessWidget {
  const DashboardStatusGrid({super.key});

  static const Color runningColor = Color(0xff087c2b);
  static const Color stoppageColor = Color(0xffff222a);
  static const Color idleColor = Color(0xffff9800);
  static const Color inactiveColor = Color(0xff216dff);
  static const Color neutralBarColor = Color(0xffe5e5e5);

  /// Cars from the vehicle icon pack, one per status colour
  static const String _icRunning = 'assets/vehicle/car/car_running_green.png';
  static const String _icStoppage = 'assets/vehicle/car/car_stoppage_red.png';
  static const String _icIdle = 'assets/vehicle/car/car_idle_orange.png';
  static const String _icInactive = 'assets/vehicle/car/car_inactive_blue.png';
  static const String _icNoData = 'assets/vehicle/car/car_no_data_gray.png';
  static const String _icExpire =
      'assets/vehicle/car/car_expire_soon_yellow.png';

  @override
  Widget build(BuildContext context) {
    final cards = [
      const DashboardStatusCard(
        title: 'Total',
        value: '150',
        titleColor: Colors.black,
        valueColor: Colors.black,
        barColor: neutralBarColor,
      ),
      const DashboardStatusCard(
        title: 'Running',
        value: '21',
        titleColor: runningColor,
        valueColor: runningColor,
        barColor: Color(0xff50c878),
        imagePath: _icRunning,
      ),
      const DashboardStatusCard(
        title: 'Stoppage',
        value: '102',
        titleColor: Color(0xfff40f17),
        valueColor: stoppageColor,
        barColor: stoppageColor,
        imagePath: _icStoppage,
      ),
      const DashboardStatusCard(
        title: 'Idle',
        value: '16',
        titleColor: Color(0xffcf7900),
        valueColor: idleColor,
        barColor: idleColor,
        imagePath: _icIdle,
      ),
      const DashboardStatusCard(
        title: 'Inactive',
        value: '11',
        titleColor: inactiveColor,
        valueColor: inactiveColor,
        barColor: inactiveColor,
        imagePath: _icInactive,
      ),
      const DashboardStatusCard(
        title: 'No Data',
        value: '0',
        titleColor: Colors.black,
        valueColor: Colors.black,
        barColor: neutralBarColor,
        imagePath: _icNoData,
      ),
      const DashboardStatusCard(
        title: 'Expire Soon',
        value: '0',
        titleColor: Colors.black,
        valueColor: Colors.black,
        barColor: neutralBarColor,
        imagePath: _icExpire,
      ),
      const DashboardStatusCard(
        title: 'Expired',
        value: '0',
        titleColor: Colors.black,
        valueColor: Colors.black,
        barColor: neutralBarColor,
        imagePath: _icExpire,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff18548f),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(27.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      child: GridView.builder(
        itemCount: cards.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 2.3,
        ),
        itemBuilder: (context, index) => cards[index],
      ),
    );
  }
}

class DashboardStatusCard extends StatelessWidget {
  const DashboardStatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.titleColor,
    required this.valueColor,
    required this.barColor,
    this.imagePath,
    this.imageTint,
  });

  final String title;
  final String value;
  final Color titleColor;
  final Color valueColor;
  final Color barColor;
  final String? imagePath;
  final Color? imageTint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/dashboardVehicleListView');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          color: AppColors.whiteColor,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 8.h, 8.w, 4.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomWidget.text(
                              title,
                              color: titleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3.h),
                            CustomWidget.text(
                              value,
                              color: valueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),
                      if (imagePath != null) ...[
                        SizedBox(width: 4.w),
                        _VehicleStatusImage(
                          imagePath: imagePath!,
                          tint: imageTint,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Container(
                height: 6.h,
                color: barColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VehicleStatusImage extends StatelessWidget {
  const _VehicleStatusImage({
    required this.imagePath,
    this.tint,
  });

  final String imagePath;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      imagePath,
      width: 54.w,
      height: 22.h,
      fit: BoxFit.contain,
      color: tint,
      colorBlendMode: tint == null ? null : BlendMode.srcATop,
    );

    return image;
  }
}
