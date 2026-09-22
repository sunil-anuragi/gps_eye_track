import 'dart:convert';

import 'package:get/get.dart';
import 'package:gps_software/screens/geofence/model/geofence.dart';
import 'package:gps_software/screens/geofence/view/add_geofence_view.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeofenceViewModel extends BaseController {
  static const _storeKey = 'geofences';

  final geofences = <Geofence>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadGeofences();
  }

  // Geofences are kept on the device; swap loadGeofences/_persist for the
  // geofence API when it is available.
  Future<void> loadGeofences() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    if (raw != null) {
      geofences.assignAll((jsonDecode(raw) as List)
          .map((e) => Geofence.fromJson(e as Map<String, dynamic>)));
    }
    isLoading.value = false;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storeKey,
      jsonEncode(geofences.map((g) => g.toJson()).toList()),
    );
  }

  /// Opens the map to draw a new geofence, or to change [geofence]
  Future<void> openEditor([Geofence? geofence]) async {
    final result = await Get.toNamed(
      AddGeofenceView.addGeofenceView,
      arguments: geofence,
    );
    if (result is! Geofence) return;

    final index = geofences.indexWhere((g) => g.id == result.id);
    if (index == -1) {
      geofences.add(result);
    } else {
      geofences[index] = result;
    }
    await _persist();
    showSnack(msg: 'Geofence "${result.name}" saved');
  }

  Future<void> deleteGeofence(Geofence geofence) async {
    geofences.removeWhere((g) => g.id == geofence.id);
    await _persist();
    showSnack(msg: 'Geofence "${geofence.name}" deleted');
  }
}
