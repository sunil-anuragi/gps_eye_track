import 'dart:convert';
import 'dart:developer';

import 'package:gps_software/enum/map_type.dart';
import 'package:gps_software/util/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  static const String _keyReloginAtMs = "relogin_at_ms";
  static const String _keyReloginEmail = "relogin_email";
  static const String _keyReloginPassword = "relogin_password";

  Future<void> saveUserDetails(AuthenticationModel authModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user", jsonEncode(authModel.toJson()));
  }

  Future<void> logoutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("user");
    await clearReloginSchedule();
  }

  Future<AuthenticationModel> get getSaveUserDetails async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString("user");
    log("message  ==>  $userData");
    if (userData == null) {
      return AuthenticationModel();
    }
    return authenticationModelFromJson(userData);
  }

  Future<bool> get isShowOnBoarding async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    logger("HEYYYY---${sharedPreferences.getBool("isShowOnBoarding")}");
    return sharedPreferences.getBool("isShowOnBoarding") ?? false;
  }

  Future<void> onBoarding({required bool isShowOnBoarding}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isShowOnBoarding", isShowOnBoarding);
  }

  Future<bool> get isShowLanguage async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    logger("HEYYYY---${sharedPreferences.getBool("isShowLanguage")}");
    return sharedPreferences.getBool("isShowLanguage") ?? true;
  }

  Future<void> showLanguage({required bool isShowLanguage}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isShowLanguage", isShowLanguage);
  }

  Future<String> get getLanguage async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("language") ?? "en";
  }

  Future<void> setLanguage({required String language}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("language", language);
  }

  Future<void> setVoiceNotificationOn({required bool isVoiceOn}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isVoiceOn", isVoiceOn);
  }

  Future<bool> get getVoiceNotificationOn async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isVoiceOn") ?? true;
  }

  Future<void> setMapType({required String mapType}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("mapType", mapType);
  }

  Future<String> get getMapType async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("mapType") ?? MapTypeEnum.Terrain.name;
  }

  /// Seconds between automatic refreshes on the tracking screens
  Future<int> get getRefreshSeconds async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt("refreshSeconds") ?? 10;
  }

  Future<void> setRefreshSeconds({required int seconds}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("refreshSeconds", seconds);
  }

  /// How the marker moves between points: `slow` or `jump`
  Future<String> get getVehicleMotion async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("vehicleMotion") ?? "slow";
  }

  Future<void> setVehicleMotion({required String motion}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("vehicleMotion", motion);
  }

  /// Screen shown when the app launches: `map` or `list`
  Future<String> get getStartupScreen async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("startupScreen") ?? "map";
  }

  Future<void> setStartupScreen({required String screen}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("startupScreen", screen);
  }

  Future<bool> get getReceiveNotification async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("receiveNotification") ?? true;
  }

  Future<void> setReceiveNotification({required bool isOn}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("receiveNotification", isOn);
  }

  Future<void> setHistoryColor({required String historyColor}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("historyColor", historyColor);
  }

  Future<String> get getHistoryColor async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("historyColor") ?? "FF2196F3";
  }

  Future<void> saveSupportDetail({ContactModel? supportdata}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "supportData", jsonEncode(supportdata!.toJson()));
  }

  Future<ContactModel?> get getsaveSupportDetail async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? supportData = sharedPreferences.getString("supportData");

    log("message  ==>  $supportData");
    if (supportData == null) {
      return null;
    }
    return contactModelFromJson(supportData);
  }

  Future<void> setReloginSchedule({
    required int reloginAtMs,
    required String email,
    required String password,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setInt(_keyReloginAtMs, reloginAtMs);
    await sharedPreferences.setString(_keyReloginEmail, email);
    await sharedPreferences.setString(_keyReloginPassword, password);
  }

  Future<int?> get getReloginAtMs async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt(_keyReloginAtMs);
  }

  Future<Map<String, String>?> get getReloginCredentials async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? email = sharedPreferences.getString(_keyReloginEmail);
    final String? password = sharedPreferences.getString(_keyReloginPassword);
    if (email == null || password == null) return null;
    return {"email": email, "password": password};
  }

  Future<void> clearReloginSchedule() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(_keyReloginAtMs);
    await sharedPreferences.remove(_keyReloginEmail);
    await sharedPreferences.remove(_keyReloginPassword);
  }
}

class AuthenticationModel {
  UserData? userData;
  AppSettingModel? appSettingModel;

  AuthenticationModel({this.userData, this.appSettingModel});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        userData: json["user_data"] == null
            ? null
            : UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData?.toJson(),
      };
}

class UserData {
  bool? chart;
  bool? summary;
  bool? ivrCall;
  bool? graph;
  User? user;
  String? token;

  UserData(
      {this.chart,
      this.summary,
      this.ivrCall,
      this.graph,
      this.user,
      this.token});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        chart: json["chart"],
        summary: json["summary"],
        ivrCall: json["ivrCall"],
        graph: json["graph"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "chart": chart,
        "summary": summary,
        "ivrCall": ivrCall,
        "graph": graph,
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  String? email;
  User({this.email});
  factory User.fromJson(Map<String, dynamic> json) =>
      User(email: json["email"]);
  Map<String, dynamic> toJson() => {"email": email};
}

class AppSettingModel {
  AppSettingData? appSettingData;
  AppSettingModel({this.appSettingData});
}

class AppSettingData {
  bool? addDevice;
  AppSettingData({this.addDevice});
}

AuthenticationModel authenticationModelFromJson(String str) =>
    AuthenticationModel.fromJson(json.decode(str));

class ContactModel {
  ContactModel();
  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel();
  Map<String, dynamic> toJson() => {};
}

ContactModel contactModelFromJson(String str) => ContactModel();
