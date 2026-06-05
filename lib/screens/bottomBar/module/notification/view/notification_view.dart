import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/widget/tab_app_bar.dart';
import 'package:gps_software/screens/bottomBar/module/notification/viewModel/notification_view_model.dart';
import 'package:gps_software/screens/bottomBar/module/notification/widget/notification_list_tile.dart';
import 'package:gps_software/util/app_constant.dart';

class NotificationView extends GetView<NotificationViewModel> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: TabAppBar(
        title: AppStrings.appTitle,
        leading: IconButton(
          icon: Icon(Icons.settings, color: AppColors.whiteColor, size: 22.r),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) {
          return NotificationListTile(
            notification: controller.notifications[index],
          );
        },
      ),
    );
  }
}
