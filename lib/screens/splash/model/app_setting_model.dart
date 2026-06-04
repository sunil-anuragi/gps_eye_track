import 'dart:convert';

AppSettingModel appSettingModelFromJson(String str) =>
    AppSettingModel.fromJson(json.decode(str));

String appSettingModelToJson(AppSettingModel data) =>
    json.encode(data.toJson());

class AppSettingModel {
  bool? success;
  AppSettingData? appSettingData;

  AppSettingModel({
    this.success,
    this.appSettingData,
  });

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      AppSettingModel(
        success: json["success"],
        appSettingData:
            json["data"] == null ? null : AppSettingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": appSettingData?.toJson(),
      };
}

class AppSettingData {
  bool? signUp;
  bool? addDevice;
  bool? forgetpassword;
  String? baseUrl;
  String? supportMobile;
  String? supportEmail;

  AppSettingData({
    this.signUp,
    this.addDevice,
    this.forgetpassword,
    this.baseUrl,
    this.supportMobile,
    this.supportEmail,
  });

  factory AppSettingData.fromJson(Map<String, dynamic> json) => AppSettingData(
        signUp: json["sign_up"],
        addDevice: json["add_device"],
        forgetpassword: json["forgot_password"],
        baseUrl: json["base_url"],
        supportMobile: json["support_mobile"]?.toString(),
        supportEmail: json["support_email"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "sign_up": signUp,
        "add_device": addDevice,
        "forgot_password": forgetpassword,
        "base_url": baseUrl,
        "support_mobile": supportMobile,
        "support_email": supportEmail,
      };
}
