import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gps_software/enum/vehicle_status.dart';
import 'package:gps_software/util/get_vehicle_image.dart';

/// The icon pack lives in per-type subfolders, and a bare `assets/` entry in
/// pubspec does not recurse into those. These tests fail if a folder is not
/// declared, or if a type/status pair resolves to a file that isn't shipped.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every type and status resolves to a bundled asset', () async {
    final missing = <String>[];
    for (final type in kVehicleIconTypes) {
      for (final status in VehicleStatus.values) {
        final path = getVehicleImage(type, status);
        try {
          await rootBundle.load(path);
        } catch (_) {
          missing.add(path);
        }
      }
    }
    expect(missing, isEmpty, reason: 'not bundled:\n${missing.join('\n')}');
  });

  test('legacy type codes and names all resolve to a bundled asset', () async {
    const legacy = [
      '1', '2', '4', '5', '6', '7', '8', '10', '11', '12', '13', '14', '15',
      'bike', 'car', 'bus', 'truck', 'container_truck', 'rmc_truck',
      'cylinder_truck', 'jcb', 'loader', 'ace', 'tipper', 'tractor',
      'man_lifter', 'man_elevator', 'open_truck',
      'CAR', ' Truck ', 'mixer truck', // case and spacing
      'something_unknown', // must fall back, not crash
    ];
    final missing = <String>[];
    for (final type in legacy) {
      final path = getVehicleImage(type, VehicleStatus.moving);
      try {
        await rootBundle.load(path);
      } catch (_) {
        missing.add('$type -> $path');
      }
    }
    expect(missing, isEmpty, reason: 'unresolved:\n${missing.join('\n')}');
  });

  test('status text from the API maps to the right icon colour', () {
    expect(vehicleStatusFromText('Running'), VehicleStatus.moving);
    expect(vehicleStatusFromText('Stopped (24 Min)'), VehicleStatus.parking);
    expect(vehicleStatusFromText('Idle'), VehicleStatus.idle);
    expect(vehicleStatusFromText('Inactive'), VehicleStatus.inactive);
    expect(vehicleStatusFromText('Expired'), VehicleStatus.expired);
    expect(vehicleStatusFromText('anything else'), VehicleStatus.out);
  });

  test('live status wins over expiry, so Running never shows yellow', () {
    // Regression: the vehicle menu showed a "Running" badge beside the
    // expire-soon yellow car because expiry was checked first.
    expect(
      vehicleStatusFromText('Running', isExpired: true),
      VehicleStatus.moving,
    );
    expect(
      vehicleStatusFromText('Stopped (24 Min)', isExpired: true),
      VehicleStatus.parking,
    );
    expect(vehicleStatusFromText('Idle', isExpired: true), VehicleStatus.idle);
    // With no live state in the text, expiry does decide the icon
    expect(vehicleStatusFromText('', isExpired: true), VehicleStatus.expired);
    expect(vehicleStatusFromText(''), VehicleStatus.out);
  });
}
