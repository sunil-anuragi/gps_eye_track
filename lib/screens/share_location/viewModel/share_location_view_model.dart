import 'dart:convert';

import 'package:get/get.dart';
import 'package:gps_software/screens/share_location/model/location_share.dart';
import 'package:gps_software/screens/share_location/widgets/share_edit_dialog.dart';
import 'package:gps_software/util/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareLocationViewModel extends BaseController {
  late final Map<String, dynamic> vehicle;
  late final String vehicleNo;
  late final double latitude;
  late final double longitude;

  final shares = <LocationShare>[].obs;

  static final DateFormat validFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  String get _storeKey => 'location_shares_$vehicleNo';

  @override
  void onInit() {
    super.onInit();
    vehicle = (Get.arguments as Map<String, dynamic>?) ?? {};
    vehicleNo = vehicle['vehicleNo'] as String? ?? 'DL23RW8855';
    latitude = (vehicle['latitude'] as num?)?.toDouble() ?? 22.5327;
    longitude = (vehicle['longitude'] as num?)?.toDouble() ?? 88.2045;
    _load();
  }

  // Shares are kept on the device; move to the share API when available.
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    if (raw == null) return;
    final list = (jsonDecode(raw) as List)
        .map((e) => LocationShare.fromJson(e as Map<String, dynamic>))
        .toList();
    shares.assignAll(list);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _storeKey, jsonEncode(shares.map((s) => s.toJson()).toList()));
  }

  /// Pencil in the app bar: create a new share
  Future<void> createShare() async {
    final draft = LocationShare(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: vehicleNo,
      validTill: DateTime.now().add(const Duration(hours: 1)),
    );
    final result = await Get.dialog<LocationShare>(
      ShareEditDialog(vehicleNo: vehicleNo, share: draft),
    );
    if (result == null) return;
    shares.insert(0, result);
    await _save();
    await sendShare(result);
  }

  /// Tap on a row: edit its name / validity
  Future<void> editShare(LocationShare share) async {
    final result = await Get.dialog<LocationShare>(
      ShareEditDialog(vehicleNo: vehicleNo, share: share),
    );
    if (result == null) return;
    final index = shares.indexWhere((s) => s.id == share.id);
    if (index != -1) shares[index] = result;
    await _save();
    showSnack(msg: 'Share updated');
  }

  /// Opens the share sheet for [share].
  /// The link is the vehicle's position; replace with the tracking link
  /// returned by the share API so the receiver sees live movement.
  Future<void> sendShare(LocationShare share) async {
    await Share.share(
      '${share.name} location, valid till ${validFormat.format(share.validTill)}\n'
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
      subject: '$vehicleNo location',
    );
  }
}
