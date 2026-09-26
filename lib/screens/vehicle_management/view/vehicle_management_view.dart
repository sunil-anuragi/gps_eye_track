import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/screens/vehicle_management/model/management_section.dart';
import 'package:gps_software/screens/vehicle_management/viewModel/vehicle_management_view_model.dart';
import 'package:gps_software/screens/vehicle_management/widgets/management_form.dart';
import 'package:gps_software/screens/vehicle_management/widgets/tyre_tab.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleManagementView extends GetView<VehicleManagementViewModel> {
  static const vehicleManagementView = '/vehicleManagementView';

  const VehicleManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    const sections = ManagementSection.values;

    return DefaultTabController(
      length: sections.length,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: TrackingColors.brandBlue,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: TrackingColors.brandBlue,
          elevation: 0,
          toolbarHeight: 56.h,
          centerTitle: true,
          leading: IconButton(
            onPressed: Get.back,
            icon: Icon(Icons.arrow_back_rounded,
                color: AppColors.whiteColor, size: 24.r),
          ),
          title: CustomWidget.text(
            'Vehicle Management',
            color: AppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
        body: Obx(() {
          if (!controller.isLoaded.value) {
            return const Center(
              child: CircularProgressIndicator(color: TrackingColors.brandBlue),
            );
          }
          return Column(
            children: [
              SizedBox(height: 10.h),
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                labelPadding: EdgeInsets.symmetric(horizontal: 9.w),
                labelColor: TrackingColors.brandBlue,
                unselectedLabelColor: const Color(0xff5c5c5c),
                labelStyle: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.inter),
                unselectedLabelStyle:
                    TextStyle(fontSize: 13.sp, fontFamily: AppFonts.inter),
                indicatorColor: TrackingColors.brandBlue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 1.5,
                dividerColor: Colors.transparent,
                tabs: [for (final s in sections) Tab(text: s.label)],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    for (final section in sections)
                      section == ManagementSection.tyre
                          ? const TyreTab()
                          : Obx(
                              () => ManagementForm(
                                key: ValueKey(section),
                                fields: section.fields,
                                record: controller.recordOf(section),
                                showCertificateActions: section.hasCertificate,
                                onSave: (values) =>
                                    controller.saveSection(section, values),
                              ),
                            ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
