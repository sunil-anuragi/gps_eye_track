import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/splash/viewModel/splash_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class SplashView extends StatefulWidget {
  static const splashView = '/splashView';

  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Get.find<SplashViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: CustomWidget.customAssetImageWidget(
          image: Assets.brandLogo,
          height: 220.r,
          width: 220.r,
        ),
      ),
    );
  }
}
