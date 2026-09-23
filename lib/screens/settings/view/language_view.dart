import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/commonWidget/tracking_map_widgets.dart';
import 'package:gps_software/custom_widget.dart';
import 'package:gps_software/generated/assets.dart';
import 'package:gps_software/screens/settings/viewModel/setting_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class LanguageView extends StatefulWidget {
  static const languageView = '/languageView';

  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  final SettingViewModel controller = Get.find<SettingViewModel>();
  late AppLanguage _picked = controller.language.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef2f7),
      appBar: const TrackingAppBar(title: 'Language'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 18.h,
                childAspectRatio: 1.15,
                children: [
                  for (final language in AppLanguage.values)
                    _LanguageTile(
                      language: language,
                      selected: _picked == language,
                      onTap: () => setState(() => _picked = language),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => _confirm(_picked),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TrackingColors.brandBlue,
                  foregroundColor: AppColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                ),
                child: CustomWidget.text(
                  'Continue with',
                  color: AppColors.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Saves the choice, then asks to restart so every built screen re-reads it
  Future<void> _confirm(AppLanguage language) async {
    await controller.saveLanguage(language);
    Get.dialog<void>(
      Dialog(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 26.w),
        shape: const RoundedRectangleBorder(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 12.w, 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomWidget.text(
                'Application Restart Required',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: Get.back,
                    child: CustomWidget.text(
                      'Cancel',
                      color: const Color(0xff1a73e8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      Get.updateLocale(Locale(language.code));
                      Get.back();
                    },
                    child: CustomWidget.text(
                      'Restart',
                      color: const Color(0xff1a73e8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// White card with the language's landmark and its name
class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  /// Landmark standing in for each language: Tower Bridge, India Gate,
  /// the Statue of Unity and the Gateway of India
  String get _landmark => switch (language) {
        AppLanguage.english => Assets.langEnglish,
        AppLanguage.hindi => Assets.langHindi,
        AppLanguage.gujarati => Assets.langGujarati,
        AppLanguage.marathi => Assets.langMarathi,
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? TrackingColors.brandBlue : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _landmark,
              width: 56.r,
              height: 56.r,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 12.h),
            CustomWidget.text(
              language.label,
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ],
        ),
      ),
    );
  }
}
