import 'dart:convert';
import 'package:gps_software/enum/vehicle_status.dart';

AllTripModel allTripModelFromJson(String str) =>
    AllTripModel.fromJson(json.decode(str));

String allTripModelToJson(AllTripModel data) => json.encode(data.toJson());

class AllTripModel {
  bool? success;
  List<AllVehicle>? allVehicle;
  int? statusCode;

  AllTripModel({
    this.success,
    this.allVehicle,
    this.statusCode,
  });

  factory AllTripModel.fromJson(Map<String, dynamic> json) => AllTripModel(
        success: json["success"],
        allVehicle: json["data"] == null
            ? []
            : List<AllVehicle>.from(
                json["data"]!.map((x) => AllVehicle.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": allVehicle == null
            ? []
            : List<dynamic>.from(allVehicle!.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class AllVehicle {
  int? id;
  int? tankCount;
  int? vehicleTypeId;
  int? deviceTypeId;
  String? vehicleType;
  String? vehicleShortName;
  int? speedLimit;
  String? vehicleName;
  String? address;
  dynamic deviceimei;
  dynamic simMobno;
  DateTime? installationDate;
  DateTime? expireDate;
  int? safeParking;
  int? enableImmobilizer;
  int? safeParkingAlert;
  int? fuelDipAlert;
  int? immobilizerOption;
  int? ignitionRank;
  VehicleStatus? currentStatus;
  int? vehicleStatus;
  double? latitude;
  double? longitude;
  int? ignition;
  int? acStatus;
  int? speed;
  int? angle;
  double? odometer;
  DateTime? deviceUpdatedtime;
  dynamic temperature;
  dynamic deviceBatteryVolt;
  double? vehicleBatteryVolt;
  int? batteryPercentage;
  dynamic doorStatus;
  int? powerStatus;
  String? lastDuration;
  dynamic fuelLitre;
  int? immobilizerStatus;
  String? gpssignal;
  String? gsmStatus;
  String? rpmValue;
  int? secEngineStatus;
  int? expiryStatus;
  var todayDistance;
  String? deviceMake;
  String? deviceModel;
  int? deviceMakeId;
  int? deviceModelId;
  int? vehicleId;
  String? packageName;
  String? tempUpdatedatetime;
  String? fuelUpdatedatetime;
  String? fuelUpdatedatetime2;
  dynamic fuelLitre1;
  dynamic fuelLitre2;
  dynamic fuelLitre3;
  dynamic temperature1;
  dynamic temperature2;
  dynamic temperature3;
  List<AvailableChannel>? availableChannels;
  String? dashcamDeviceType;
  int? powerStatusAlert;
  String? currentStatusUpdatedOn;
  String? ivrCallPoint;
  int? fenceId;

  AllVehicle({
    this.id,
    this.tankCount,
    this.vehicleTypeId,
    this.deviceTypeId,
    this.vehicleType,
    this.vehicleShortName,
    this.speedLimit,
    this.vehicleName,
    this.address,
    this.deviceimei,
    this.enableImmobilizer,
    this.simMobno,
    this.installationDate,
    this.expireDate,
    this.safeParking,
    this.safeParkingAlert,
    this.immobilizerOption,
    this.ignitionRank,
    this.currentStatus,
    this.vehicleStatus,
    this.latitude,
    this.longitude,
    this.ignition,
    this.acStatus,
    this.speed,
    this.angle,
    this.odometer,
    this.deviceUpdatedtime,
    this.temperature,
    this.deviceBatteryVolt,
    this.vehicleBatteryVolt,
    this.batteryPercentage,
    this.doorStatus,
    this.powerStatus,
    this.lastDuration,
    this.fuelLitre,
    this.immobilizerStatus,
    this.gpssignal,
    this.gsmStatus,
    this.rpmValue,
    this.secEngineStatus,
    this.expiryStatus,
    this.todayDistance,
    this.deviceMake,
    this.deviceModel,
    this.deviceMakeId,
    this.deviceModelId,
    this.vehicleId,
    this.packageName,
    this.tempUpdatedatetime,
    this.fuelUpdatedatetime,
    this.fuelUpdatedatetime2,
    this.fuelLitre1,
    this.fuelLitre2,
    this.fuelLitre3,
    this.temperature1,
    this.temperature2,
    this.temperature3,
    this.fuelDipAlert,
    this.availableChannels,
    this.dashcamDeviceType,
    this.powerStatusAlert,
    this.currentStatusUpdatedOn,
    this.ivrCallPoint,
    this.fenceId,
  });

  factory AllVehicle.fromJson(Map<String, dynamic> json) => AllVehicle(
        id: json["id"],
        tankCount: json["tank_count"],
        vehicleTypeId: json["vehicle_type_id"],
        deviceTypeId: json["device_type_id"],
        vehicleType: json["vehicle_type"],
        vehicleShortName: json["vehicle_short_name"],
        address: json["address"],
        speedLimit: json["speed_limit"],
        vehicleName: json["vehicle_name"],
        deviceimei: json["deviceimei"],
        simMobno: json["sim_mob_no"],
        enableImmobilizer: json["enable_immobilizer"],
        installationDate: json["installation_date"] == null
            ? null
            : DateTime.parse(json["installation_date"]),
        expireDate: json["expire_date"] == null
            ? null
            : DateTime.parse(json["expire_date"]),
        safeParking: json["safe_parking"],
        safeParkingAlert: json["safe_parking_alert"],
        immobilizerOption: json["immobilizer_option"],
        ignitionRank: json["ignition_rank"],
        currentStatus: json["current_status"] == null
            ? null
            : AllVehicle().getCurrentStatus(json["current_status"]),
        vehicleStatus: json["vehicle_status"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        ignition: json["ignition"],
        acStatus: json["ac_status"],
        speed: json["speed"],
        angle: json["angle"],
        odometer: json["odometer"]?.toDouble(),
        deviceUpdatedtime: json["device_updatedtime"] == null
            ? null
            : DateTime.parse(json["device_updatedtime"]),
        temperature: json["temperature"],
        deviceBatteryVolt: json["device_battery_volt"],
        vehicleBatteryVolt: json["vehicle_battery_volt"]?.toDouble(),
        batteryPercentage: json["battery_percentage"],
        doorStatus: json["door_status"],
        powerStatus: json["power_status"],
        lastDuration: json["last_duration"],
        fuelLitre: json["fuel_litre"],
        immobilizerStatus: json["immobilizer_status"],
        gpssignal: json["gpssignal"],
        gsmStatus: json["gsm_status"],
        rpmValue: json["rpm_value"],
        secEngineStatus: json["sec_engine_status"],
        expiryStatus: json["expiry_status"],
        todayDistance: json["today_distance"],
        deviceMake: json["device_make"],
        deviceModel: json["device_model"],
        deviceMakeId: json["device_make_id"],
        deviceModelId: json["device_model_id"],
        vehicleId: json["vehicle_id"],
        packageName: json["package_name"],
        tempUpdatedatetime: json["temp_updatedatetime"],
        fuelUpdatedatetime: json["fuel_updatedatetime"],
        fuelUpdatedatetime2: json["fuel_updatedatetime2"],
        fuelLitre1: json["fuel_litre1"],
        fuelLitre2: json["fuel_litre2"],
        fuelLitre3: json["fuel_litre3"],
        temperature1: json["temperature1"],
        temperature2: json["temperature2"],
        temperature3: json["temperature3"],
        fuelDipAlert: json["fuel_dip_alert"],
        availableChannels: json["available_channels"] == null
            ? []
            : List<AvailableChannel>.from(json["available_channels"]!
                .map((x) => AvailableChannel.fromJson(x))),
        dashcamDeviceType: json["dashcam_device_type"],
        powerStatusAlert: json["power_status_alert"],
        currentStatusUpdatedOn: json["current_status_updated_on"],
        ivrCallPoint: json["ivr_call_point"],
        fenceId: json["fence_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tank_count": tankCount,
        "vehicle_type_id": vehicleTypeId,
        "device_type_id": deviceTypeId,
        "vehicle_type": vehicleType,
        "vehicle_vehicle_short_name": vehicleShortName,
        "speed_limit": speedLimit,
        "vehicle_name": vehicleName,
        "address": address,
        "deviceimei": deviceimei,
        "enable_immobilizer": enableImmobilizer,
        "sim_mob_no": simMobno,
        "installation_date": installationDate != null
            ? "${installationDate!.year.toString().padLeft(4, '0')}-${installationDate!.month.toString().padLeft(2, '0')}-${installationDate!.day.toString().padLeft(2, '0')}"
            : null,
        "expire_date": expireDate != null
            ? "${expireDate!.year.toString().padLeft(4, '0')}-${expireDate!.month.toString().padLeft(2, '0')}-${expireDate!.day.toString().padLeft(2, '0')}"
            : null,
        "safe_parking": safeParking,
        "safe_parking_alert": safeParkingAlert,
        "immobilizer_option": immobilizerOption,
        "ignition_rank": ignitionRank,
        "current_status": currentStatus,
        "vehicle_status": vehicleStatus,
        "latitude": latitude,
        "longitude": longitude,
        "ignition": ignition,
        "ac_status": acStatus,
        "speed": speed,
        "angle": angle,
        "odometer": odometer,
        "device_updatedtime": deviceUpdatedtime?.toIso8601String(),
        "temperature": temperature,
        "device_battery_volt": deviceBatteryVolt,
        "vehicle_battery_volt": vehicleBatteryVolt,
        "battery_percentage": batteryPercentage,
        "door_status": doorStatus,
        "power_status": powerStatus,
        "last_duration": lastDuration,
        "fuel_litre": fuelLitre,
        "immobilizer_status": immobilizerStatus,
        "gpssignal": gpssignal,
        "gsm_status": gsmStatus,
        "rpm_value": rpmValue,
        "sec_engine_status": secEngineStatus,
        "expiry_status": expiryStatus,
        "today_distance": todayDistance,
        "device_make": deviceMake,
        "device_model": deviceModel,
        "device_make_id": deviceMakeId,
        "device_model_id": deviceModelId,
        "vehicle_id": vehicleId,
        "package_name": packageName,
        "temp_updatedatetime": tempUpdatedatetime,
        "fuel_updatedatetime": fuelUpdatedatetime,
        "fuel_updatedatetime2": fuelUpdatedatetime2,
        "fuel_litre1": fuelLitre1,
        "fuel_litre2": fuelLitre2,
        "fuel_litre3": fuelLitre3,
        "temperature1": temperature1,
        "temperature2": temperature2,
        "temperature3": temperature3,
        "fuel_dip_alert": fuelDipAlert,
        "available_channels": availableChannels == null
            ? []
            : List<dynamic>.from(availableChannels!.map((x) => x.toJson())),
        "dashcam_device_type": dashcamDeviceType,
        "power_status_alert": powerStatusAlert,
        "current_status_updated_on": currentStatusUpdatedOn,
        "ivr_call_point": ivrCallPoint,
        "fence_id": fenceId,
      };

  VehicleStatus getCurrentStatus(String status) {
    switch (status) {
      case ("Moving" || "moving"):
        return VehicleStatus.moving;
      case ("Parking" || "parking"):
        return VehicleStatus.parking;
      case ("Idle" || "idle"):
        return VehicleStatus.idle;
      case ("Out" || "out" || "No Data"):
        return VehicleStatus.out;
      case ("InActive" || "inactive" || "inActive"):
        return VehicleStatus.inactive;
      case ("Expired" || "expired"):
        return VehicleStatus.expired;
      default:
        return VehicleStatus.moving;
    }
  }
}

class AvailableChannel {
  String? id;
  String? name;

  AvailableChannel({
    this.id,
    this.name,
  });

  factory AvailableChannel.fromJson(Map<String, dynamic> json) =>
      AvailableChannel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
