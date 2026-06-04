import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/util/app_constant.dart';

import '../generated/assets.dart';

class CustomAppBar extends GetView<GetxController> {
  const CustomAppBar({
    super.key,
    required this.title,
    this.action,
    this.isShowDrawer = false,
    this.centerTitlevalue = true,
    this.isShowBackButton = true,
  });

  final String title;

  final Widget? action;
  final bool isShowDrawer;
  final bool centerTitlevalue;
  final bool isShowBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: centerTitlevalue,
      leading: isShowBackButton
          ? null
          : Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: CustomWidget.customAssetImageWidget(
                      image: Assets.assetsDrawer, height: 15.h, width: 15.w)),
            ),

      // leading: Visibility(
      //   visible: isShowDrawer,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 22),
      //     child: InkWell(
      //         onTap: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //         child: CustomWidget.customAssetImageWidget(
      //             image: Assets.assetsDrawer, height: 20.8.h, width: 12.6.w)),
      //   ),
      // ),
      title: CustomWidget.text(title,
          fontSize: title == "Fuel Graph" || title == "Live Stream" ? 12 : 18,
          fontWeight: FontWeight.w600),
      actions: [action ?? const Row()],
      automaticallyImplyLeading: true,
      scrolledUnderElevation: 0,
    );
  }
}
