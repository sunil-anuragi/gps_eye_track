import 'package:get/get.dart';
import 'package:gps_software/enum/map_type.dart';
import 'package:gps_software/util/user_details.dart';

/// How the vehicle marker moves between two points
enum VehicleMotion {
  slow('slow', 'Slow Motion'),
  jump('jump', 'Jump Motion');

  const VehicleMotion(this.key, this.label);

  final String key;
  final String label;

  static VehicleMotion fromKey(String key) =>
      values.firstWhere((m) => m.key == key, orElse: () => VehicleMotion.slow);
}

/// Screen the app opens on
enum StartupScreen {
  map('map', 'Map'),
  list('list', 'Vehicle List');

  const StartupScreen(this.key, this.label);

  final String key;
  final String label;

  static StartupScreen fromKey(String key) =>
      values.firstWhere((s) => s.key == key, orElse: () => StartupScreen.map);
}

/// A language the app can be shown in.
/// [code] must match a locale key in `lib/translations/lang.dart`.
enum AppLanguage {
  english('en', 'English'),
  hindi('hi', 'हिंदी'),
  gujarati('gu', 'ગુજરાતી'),
  marathi('mr', 'मराठी');

  const AppLanguage(this.code, this.label);

  final String code;
  final String label;

  static AppLanguage fromCode(String code) => values
      .firstWhere((l) => l.code == code, orElse: () => AppLanguage.english);
}

/// Seconds offered by the "Set Refresh Time" dialog
const List<int> kRefreshOptions = [10, 20, 30, 45, 60];

/// Holds every preference shown on the settings screen.
/// Values are read once on init and written straight through to [UserDetails].
class SettingViewModel extends GetxController {
  final UserDetails _store = UserDetails();

  final language = AppLanguage.english.obs;
  final mapType = MapTypeEnum.Terrain.obs;
  final refreshSeconds = 10.obs;
  final motion = VehicleMotion.slow.obs;
  final startupScreen = StartupScreen.map.obs;
  final receiveNotification = true.obs;
  final voiceNotification = true.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    final savedMapType = await _store.getMapType;
    language.value = AppLanguage.fromCode(await _store.getLanguage);
    mapType.value = MapTypeEnum.values.firstWhere(
      (t) => t.name == savedMapType,
      orElse: () => MapTypeEnum.Terrain,
    );
    refreshSeconds.value = await _store.getRefreshSeconds;
    motion.value = VehicleMotion.fromKey(await _store.getVehicleMotion);
    startupScreen.value = StartupScreen.fromKey(await _store.getStartupScreen);
    receiveNotification.value = await _store.getReceiveNotification;
    voiceNotification.value = await _store.getVoiceNotificationOn;
  }

  Future<void> saveMapType(MapTypeEnum type) async {
    mapType.value = type;
    await _store.setMapType(mapType: type.name);
  }

  Future<void> saveRefreshSeconds(int seconds) async {
    refreshSeconds.value = seconds;
    await _store.setRefreshSeconds(seconds: seconds);
  }

  Future<void> saveMotion(VehicleMotion value) async {
    motion.value = value;
    await _store.setVehicleMotion(motion: value.key);
  }

  Future<void> saveStartupScreen(StartupScreen value) async {
    startupScreen.value = value;
    await _store.setStartupScreen(screen: value.key);
  }

  Future<void> saveReceiveNotification(bool value) async {
    receiveNotification.value = value;
    await _store.setReceiveNotification(isOn: value);
  }

  Future<void> saveVoiceNotification(bool value) async {
    voiceNotification.value = value;
    await _store.setVoiceNotificationOn(isVoiceOn: value);
  }

  /// Persists the language. The app still has to restart for every already
  /// built screen to pick it up, which [LanguageView] asks the user to do.
  Future<void> saveLanguage(AppLanguage value) async {
    language.value = value;
    await _store.setLanguage(language: value.code);
  }
}
