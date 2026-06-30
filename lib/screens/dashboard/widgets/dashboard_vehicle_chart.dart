import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardVehicleChart extends StatelessWidget {
  const DashboardVehicleChart({super.key});

  static const List<VehicleChartSegment> chartData = [
    VehicleChartSegment('Stoppage', 102, Color(0xffff171b)),
    VehicleChartSegment('Idle', 16, Color(0xffff9d08)),
    VehicleChartSegment('Inactive', 11, Color(0xff0f63ff)),
    VehicleChartSegment('Running', 21, Color(0xff007c2a)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270.h,
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        annotations: [
          CircularChartAnnotation(
            widget: Container(
              width: 120.w,
              height: 120.w,
              decoration: const BoxDecoration(
                color: Color(0xffd6dbde),
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget.text(
                    '150',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                  ),
                  CustomWidget.text(
                    'Vehicles',
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
        series: <CircularSeries<VehicleChartSegment, String>>[
          DoughnutSeries<VehicleChartSegment, String>(
            dataSource: chartData,
            xValueMapper: (segment, _) => segment.label,
            yValueMapper: (segment, _) => segment.value,
            pointColorMapper: (segment, _) => segment.color,
            dataLabelMapper: (segment, _) => segment.value.toString(),
            radius: '95%',
            innerRadius: '55%',
            cornerStyle: CornerStyle.bothFlat,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              textStyle: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: 'Dmsans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleChartSegment {
  const VehicleChartSegment(this.label, this.value, this.color);

  final String label;
  final int value;
  final Color color;
}
