import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';

class SupportIllustrationWidget extends StatelessWidget {
  const SupportIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: CustomWidget.customAssetImageWidget(
        image: Assets.assetsSupportIllustration,
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
