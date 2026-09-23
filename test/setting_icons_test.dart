import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gps_software/screens/settings/widgets/setting_icons.dart';

/// Every settings icon has to survive an unbounded height, because the rows
/// live in a ListView. Several icons are Stacks made only of Positioned
/// children, which cannot size themselves and assert without an explicit box.
void main() {
  testWidgets('settings icons lay out inside an unbounded ListView row',
      (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                for (final icon in SettingIcon.values)
                  Row(
                    children: [
                      settingIcon(icon, size: 30),
                      const Expanded(child: Text('row')),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('row'), findsNWidgets(SettingIcon.values.length));
  });
}
