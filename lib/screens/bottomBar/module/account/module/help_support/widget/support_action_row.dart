import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';

class SupportActionRow extends GetView<AccountViewModel> {
  const SupportActionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _actionButton(
            image: Assets.assetsSupportCall,
            onTap: controller.onPhoneTap,
          ),
          _actionButton(
            image: Assets.assetsSupportWhatsapp,
            onTap: controller.onWhatsAppTap,
          ),
          _actionButton(
            image: Assets.assetsSupportGmail,
            onTap: controller.onGmailTap,
          ),
          _actionButton(
            image: Assets.assetsSupportSms,
            onTap: controller.onEmailTap,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomWidget.customAssetImageWidget(
        image: image,
        height: 30.r,
        width: 30.r,
        fit: BoxFit.contain,
      ),
    );
  }
}
