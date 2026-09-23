import 'package:flutter/material.dart';
import 'package:gps_software/generated/assets.dart';

/// Rows of the settings screen that carry an icon
enum SettingIcon {
  language,
  tone,
  mapType,
  refresh,
  changeScreen,
  motion,
  share,
}

String _asset(SettingIcon icon) => switch (icon) {
      SettingIcon.language => Assets.settingIcLanguage,
      SettingIcon.tone => Assets.settingIcTone,
      SettingIcon.mapType => Assets.settingIcMapType,
      SettingIcon.refresh => Assets.settingIcRefresh,
      SettingIcon.changeScreen => Assets.settingIcScreen,
      SettingIcon.motion => Assets.settingIcMotion,
      SettingIcon.share => Assets.settingIcShare,
    };

/// Illustrated settings icon, drawn inside a [size] square.
///
/// The box is required rather than cosmetic: the rows live in a ListView, so
/// the incoming height is unbounded and the image needs a definite one.
Widget settingIcon(SettingIcon icon, {required double size}) {
  return SizedBox(
    width: size,
    height: size,
    child: Image.asset(_asset(icon), fit: BoxFit.contain),
  );
}
