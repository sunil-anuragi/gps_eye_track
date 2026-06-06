import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class AccountMenuTile extends StatelessWidget {
  const AccountMenuTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final AccountMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Image.asset(
                  item.icon,
                  height: 20.h,
                  width: 20.w,
                ),
                16.w.sizeBoxFromWidth(),
                Expanded(
                  child: CustomWidget.text(
                    item.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20.r,
                  color: AppColors.grayColor,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1.0,
          color: AppColors.dividerColor,
        ),
      ],
    );
  }
}
