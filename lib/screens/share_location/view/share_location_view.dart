import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/reports/view/common/report_widgets.dart';
import 'package:gps_software/screens/share_location/model/location_share.dart';
import 'package:gps_software/screens/share_location/viewModel/share_location_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

/// Location shares of a vehicle; the pencil creates a new one.
class ShareLocationView extends GetView<ShareLocationViewModel> {
  static const shareLocationView = '/shareLocationView';

  const ShareLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReportColors.background,
      appBar: ReportAppBar(
        title: controller.vehicleNo,
        actions: [
          IconButton(
            onPressed: controller.createShare,
            icon: Icon(Icons.edit, color: AppColors.whiteColor, size: 22.r),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Obx(() {
        if (controller.shares.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.share_location,
                    size: 64.r, color: Colors.grey.shade400),
                SizedBox(height: 12.h),
                CustomWidget.text(
                  'No shared locations yet.\nTap ✎ to share this vehicle.',
                  color: ReportColors.greyText,
                  fontSize: 13,
                  letterSpacing: 0,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          itemCount: controller.shares.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (_, index) => _ShareRow(
            share: controller.shares[index],
            onTap: () => controller.editShare(controller.shares[index]),
            onLongPress: () => controller.sendShare(controller.shares[index]),
          ),
        );
      }),
    );
  }
}

class _ShareRow extends StatelessWidget {
  const _ShareRow({
    required this.share,
    required this.onTap,
    required this.onLongPress,
  });

  final LocationShare share;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    Widget text(String value) => CustomWidget.text(
          value,
          color: AppColors.whiteColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          maxLine: 1,
        );

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 46.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: ReportColors.panel,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    text(share.name),
                    SizedBox(width: 24.w),
                    text(ShareLocationViewModel.validFormat
                        .format(share.validTill)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            CustomWidget.text(
              share.isActive ? 'Active' : 'Expired',
              color: share.isActive
                  ? AppColors.whiteColor
                  : const Color(0xffff8a80),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right, color: AppColors.whiteColor, size: 20.r),
          ],
        ),
      ),
    );
  }
}
