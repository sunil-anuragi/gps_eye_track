import '../enum/vehicle_status.dart';

/// Vehicle artwork lives in `assets/vehicle/<type>/<type>_<status>.png`
/// (12 types x 6 statuses, 256x256, transparent).
const String _vehicleBasePath = 'assets/vehicle';

/// Folder names shipped in the icon pack
const List<String> kVehicleIconTypes = [
  'bike',
  'boat',
  'bus',
  'car',
  'crane',
  'delivery_van',
  'excavator',
  'mixer_truck',
  'pickup',
  'scissor_lift',
  'tractor',
  'truck',
];

/// Maps every vehicle type the API sends — numeric codes and names alike — to
/// a folder in the pack. Types with no artwork of their own fall back to the
/// closest match: a tipper is drawn as a truck, a JCB as an excavator.
const Map<String, String> _typeAliases = {
  '1': 'bike',
  '2': 'car',
  '4': 'bus',
  '5': 'truck',
  '6': 'truck', // container_truck
  '7': 'mixer_truck', // rmc_truck
  '8': 'truck', // cylinder_truck
  '10': 'excavator', // jcb
  '11': 'excavator', // loader
  '12': 'crane', // ace
  '13': 'truck', // tipper
  '14': 'tractor',
  '15': 'scissor_lift', // man_lifter
  'container_truck': 'truck',
  'container': 'truck',
  'rmc_truck': 'mixer_truck',
  'cylinder_truck': 'truck',
  'jcb': 'excavator',
  'loader': 'excavator',
  'ace': 'crane',
  'tipper': 'truck',
  'open_truck': 'pickup',
  'man_lifter': 'scissor_lift',
  'man_elevator': 'scissor_lift',
  'van': 'delivery_van',
  'lorry': 'truck',
  'motorcycle': 'bike',
  'scooter': 'bike',
  'ship': 'boat',
};

/// Status suffix used by the icon pack
String _statusSuffix(VehicleStatus status) => switch (status) {
      VehicleStatus.moving => 'running_green',
      VehicleStatus.parking => 'stoppage_red',
      VehicleStatus.idle => 'idle_orange',
      VehicleStatus.inactive => 'inactive_blue',
      VehicleStatus.out => 'no_data_gray',
      VehicleStatus.expired => 'expire_soon_yellow',
    };

/// Resolves a vehicle type to a folder in the pack, falling back to `truck`
String vehicleIconFolder(String vehicleType) {
  final key = vehicleType.trim().toLowerCase().replaceAll(' ', '_');
  if (kVehicleIconTypes.contains(key)) return key;
  return _typeAliases[key] ?? 'truck';
}

/// Asset path of the icon for [vehicleType] in [vehicleStatus]
String getVehicleImage(String vehicleType, VehicleStatus vehicleStatus) {
  final folder = vehicleIconFolder(vehicleType);
  return '$_vehicleBasePath/$folder/${folder}_${_statusSuffix(vehicleStatus)}.png';
}

/// Reads the status text the API sends ("Running", "Stopped (2 Min)",
/// "Idle", "Expired", ...) into a [VehicleStatus].
///
/// Live movement wins over [isExpired]: a running vehicle whose plan has
/// lapsed still gets the green icon, because showing a yellow "expire soon"
/// car next to a "Running" badge reads as a bug. Expiry only decides the icon
/// when the status text carries no live state of its own, and screens that
/// need to show expiry do so in their own text.
VehicleStatus vehicleStatusFromText(String status, {bool isExpired = false}) {
  final text = status.toLowerCase();
  if (text.contains('run') || text.contains('moving')) {
    return VehicleStatus.moving;
  }
  if (text.contains('idle')) return VehicleStatus.idle;
  if (text.contains('stop') || text.contains('park')) {
    return VehicleStatus.parking;
  }
  if (text.contains('expire')) return VehicleStatus.expired;
  if (text.contains('inactive')) return VehicleStatus.inactive;
  if (isExpired) return VehicleStatus.expired;
  return VehicleStatus.out;
}
