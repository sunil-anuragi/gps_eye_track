import 'dart:convert';

import 'package:get/get.dart';
import 'package:gps_software/screens/vehicle_management/model/management_section.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleManagementViewModel extends BaseController {
  late final String vehicleNo;

  /// Saved form per tab (all tabs except tyre)
  final records = <ManagementSection, ManagementRecord>{}.obs;

  /// Saved tyres
  final tyres = <ManagementRecord>[].obs;

  final isLoaded = false.obs;

  String get _storeKey => 'vehicle_management_$vehicleNo';

  @override
  void onInit() {
    super.onInit();
    final vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'DL23RW8855';
    _load();
  }

  ManagementRecord recordOf(ManagementSection section) =>
      records[section] ?? ManagementRecord.empty;

  // Data is kept on the device; swap _load/_persist for the vehicle
  // management API when it is available.
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    if (raw != null) {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final sections = (json['sections'] as Map<String, dynamic>? ?? {});
      for (final entry in sections.entries) {
        final section = ManagementSection.values
            .firstWhereOrNull((s) => s.name == entry.key);
        if (section != null) {
          records[section] =
              ManagementRecord.fromJson(entry.value as Map<String, dynamic>);
        }
      }
      tyres.assignAll((json['tyres'] as List? ?? [])
          .map((e) => ManagementRecord.fromJson(e as Map<String, dynamic>)));
    }
    isLoaded.value = true;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storeKey,
      jsonEncode({
        'sections': {
          for (final e in records.entries) e.key.name: e.value.toJson(),
        },
        'tyres': tyres.map((t) => t.toJson()).toList(),
      }),
    );
  }

  Future<void> saveSection(
      ManagementSection section, Map<String, String> values) async {
    records[section] =
        ManagementRecord(values: values, lastUpdate: DateTime.now());
    await _persist();
    showSnack(msg: '${section.label} details saved');
  }

  /// Adds a tyre when [index] is null, otherwise updates that tyre
  Future<void> saveTyre(Map<String, String> values, {int? index}) async {
    final record = ManagementRecord(values: values, lastUpdate: DateTime.now());
    if (index == null) {
      tyres.add(record);
    } else {
      tyres[index] = record;
    }
    await _persist();
    showSnack(msg: 'Tyre ${(index ?? tyres.length - 1) + 1} saved');
  }
}
