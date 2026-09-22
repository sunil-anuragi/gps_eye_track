import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/vehicle_management/model/management_section.dart';
import 'package:gps_software/screens/vehicle_management/viewModel/vehicle_management_view_model.dart';
import 'package:gps_software/screens/vehicle_management/widgets/management_form.dart';
import 'package:gps_software/util/app_constant.dart';

/// Tyre tab: "Add More" and one row per saved tyre, each edited in a popup
class TyreTab extends GetView<VehicleManagementViewModel> {
  const TyreTab({super.key});

  void _openTyre({int? index}) {
    final record =
        index == null ? ManagementRecord.empty : controller.tyres[index];
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.whiteColor,
        insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 14.w, 20.h),
          child: ManagementForm(
            fields: ManagementSection.tyre.fields,
            record: record,
            shrinkWrap: true,
            buttonColor: ManagementColors.dialogButton,
            onSave: (values) async {
              await controller.saveTyre(values, index: index);
              Get.back();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 24.h),
        children: [
          SizedBox(
            height: 44.h,
            child: ElevatedButton(
              onPressed: _openTyre,
              style: ElevatedButton.styleFrom(
                backgroundColor: ManagementColors.button,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)),
              ),
              child: CustomWidget.text(
                'Add  More',
                color: AppColors.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          for (var i = 0; i < controller.tyres.length; i++) ...[
            _TyreRow(
              title: _title(i),
              onTap: () => _openTyre(index: i),
            ),
            SizedBox(height: 10.h),
          ],
        ],
      ),
    );
  }

  String _title(int index) {
    final values = controller.tyres[index].values;
    final detail = [values['company'], values['number']]
        .whereType<String>()
        .where((v) => v.isNotEmpty)
        .join(' · ');
    return detail.isEmpty
        ? 'Tyre ${index + 1}'
        : 'Tyre ${index + 1}  ($detail)';
  }
}

class _TyreRow extends StatelessWidget {
  const _TyreRow({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.only(left: 16.w, right: 12.w),
        decoration: BoxDecoration(
          color: ManagementColors.field,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomWidget.text(
                title,
                color: ManagementColors.hint,
                fontSize: 13,
                letterSpacing: 0,
                maxLine: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.edit_note_outlined,
                color: const Color(0xff5f5656), size: 22.r),
          ],
        ),
      ),
    );
  }
}
