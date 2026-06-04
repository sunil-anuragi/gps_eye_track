import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/enum/api_status_type.dart';
import 'logger.dart';

class ApiStatusManageWidget<T> extends StatelessWidget {
  final ApiStatus<T> apiStatus;
  final Widget child;
  final double? height;
  final Widget? customNoDataFound;
  final Widget? loadingWidget;

  const ApiStatusManageWidget(
      {super.key,
      required this.apiStatus,
      required this.child,
      this.height,
      this.customNoDataFound,
      this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    if (apiStatus.apiStatusType == ApiStatusType.loading) {
      return loadingWidget ??
          Container(
            height: height,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
    }
    if (apiStatus.data is List) {
      if ((apiStatus.data as List).isEmpty) {
        return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
                height: height ?? 0.7.sh,
                child: customNoDataFound ?? CustomWidget.noDataWidget()));
      }
    }

    return child;
  }
}
