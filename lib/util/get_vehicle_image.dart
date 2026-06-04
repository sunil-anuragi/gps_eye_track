import 'package:gps_software/util/app_constant.dart';

import '../enum/vehicle_status.dart';

String getVehicleImage(
  String vehicleType,
  VehicleStatus vehicleStatus,
) {
  String vehicle = AppImage.truck(type: vehicleStatus);

  switch (vehicleType) {
    case ("1" || "bike"):
      vehicle = AppImage.bike(type: vehicleStatus);
      break;
    case ("2" || "car"):
      vehicle = AppImage.car(type: vehicleStatus);
      break;
    case ("4" || "bus"):
      vehicle = AppImage.bus(type: vehicleStatus);
      break;
    case ("5" || "truck"):
      vehicle = AppImage.truck(type: vehicleStatus);
      break;
    case ("6" || "container_truck"):
      vehicle = AppImage.container(type: vehicleStatus);
      break;
    case ("7" || "rmc_truck"):
      vehicle = AppImage.rmcTruck(type: vehicleStatus);
      break;
    case ("8" || "cylinder_truck"):
      vehicle = AppImage.cylinderTruck(type: vehicleStatus);
      break;
    case ("10" || "jcb"):
      vehicle = AppImage.jcb(type: vehicleStatus);
      break;
    case ("11" || "loader"):
      vehicle = AppImage.loader(type: vehicleStatus);
      break;
    case ("12" || "ace"):
      vehicle = AppImage.ace(type: vehicleStatus);
      break;
    case ("13" || "tipper"):
      vehicle = AppImage.tipper(type: vehicleStatus);
      break;
    case ("14" || "tractor"):
      vehicle = AppImage.tractor(type: vehicleStatus);
      break;
    case ("15" || "man_lifter" || "man_elevator"):
      vehicle = AppImage.manLifter(type: vehicleStatus);
      break;
  }

  return vehicle;
}
