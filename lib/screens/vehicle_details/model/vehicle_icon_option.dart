import 'package:flutter/material.dart';

/// A marker icon the user can assign to a vehicle
class VehicleIconOption {
  const VehicleIconOption(this.key, this.label, this.icon);

  final String key;
  final String label;
  final IconData icon;

  static const List<VehicleIconOption> all = [
    VehicleIconOption('car', 'Car', Icons.directions_car_outlined),
    VehicleIconOption('bus', 'Bus', Icons.directions_bus_outlined),
    VehicleIconOption('truck', 'Truck', Icons.local_shipping),
    VehicleIconOption('bike', 'Bike', Icons.moped_outlined),
    VehicleIconOption('jcb', 'JCB', Icons.construction),
    VehicleIconOption('loader', 'Loader', Icons.forklift),
    VehicleIconOption('ace', 'Ace', Icons.airport_shuttle_outlined),
    VehicleIconOption('location', 'Location', Icons.location_on_outlined),
    VehicleIconOption('person', 'Person', Icons.person_outline),
    VehicleIconOption('pet', 'Pet', Icons.pets_outlined),
    VehicleIconOption('boat', 'Boat', Icons.directions_boat_outlined),
    VehicleIconOption('rmc_truck', 'RMC Truck', Icons.fire_truck_outlined),
    VehicleIconOption('taxi', 'Taxi', Icons.local_taxi_outlined),
    VehicleIconOption('man_lifter', 'Man Lifter', Icons.elevator_outlined),
  ];

  static VehicleIconOption byKey(String key) => all.firstWhere(
        (o) => o.key == key.toLowerCase(),
        orElse: () => all.first,
      );
}
