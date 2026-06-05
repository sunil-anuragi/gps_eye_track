import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/viewModel/bottom_bar_view_model.dart';
import 'package:gps_software/screens/bottomBar/widget/animated_tab_body.dart';
import 'package:gps_software/screens/bottomBar/widget/custom_bottom_nav_bar.dart';

class BottomBarView extends GetView<BottomBarViewModel> {
  static const bottomBarView = "/bottomBarView";
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedTabBody(
          selectedIndex: controller.selectedIndex.value,
          children: controller.buildMainScreen(),
        );
      }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
