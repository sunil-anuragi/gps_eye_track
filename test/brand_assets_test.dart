import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gps_software/generated/assets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the brand logo shown on splash and login is bundled', () async {
    final data = await rootBundle.load(Assets.brandLogo);
    expect(data.lengthInBytes, greaterThan(0));
  });

  test('launcher icon sources exist and stay out of the app bundle', () async {
    for (final path in const [
      'branding/app_icon.png',
      'branding/app_icon_foreground.png',
    ]) {
      expect(File(path).existsSync(), isTrue, reason: '$path is missing');
      // branding/ is deliberately not declared in pubspec assets, so these
      // build-time sources must not ship inside the app.
      var bundled = false;
      try {
        await rootBundle.load(path);
        bundled = true;
      } catch (_) {
        bundled = false;
      }
      expect(bundled, isFalse, reason: '$path should not be in the bundle');
    }
  });

  test('launcher icon config points at the branding sources', () {
    final config = File('flutter_launcher_icons.yaml').readAsStringSync();
    expect(config, contains('branding/app_icon.png'));
    expect(config, contains('branding/app_icon_foreground.png'));
    // A string value for `android` silently suppresses adaptive icons.
    expect(config, contains('android: true'));
  });

  test('generated launcher icons exist for both platforms', () {
    const android = [
      'android/app/src/main/res/mipmap-mdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml',
      'android/app/src/main/res/drawable-xxxhdpi/ic_launcher_foreground.png',
      'android/app/src/main/res/values/colors.xml',
    ];
    const ios =
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png';
    for (final path in [...android, ios]) {
      expect(File(path).existsSync(), isTrue, reason: '$path is missing');
    }
  });
}
