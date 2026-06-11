import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/notification/viewModel/notification_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
    required this.notification,
  });

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.notificationIgnitionKeyIcon,
                width: 40.r,
                height: 40.r,
                fit: BoxFit.contain,
              ),
              12.w.sizeBoxFromWidth(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidget.text(
                      notification.vehicleId,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                    4.h.sizeBoxFromHeight(),
                    CustomWidget.text(
                      notification.message,
                      fontSize: 10,
                      color: AppColors.subtitleColor,
                    ),
                  ],
                ),
              ),
              CustomWidget.text(
                notification.timestamp,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtitleColor,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1.0.r,
          color: AppColors.dividerColor,
        ),
      ],
    );
  }
}
