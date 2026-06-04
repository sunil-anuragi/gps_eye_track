import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gps_software/api/api.dart';
import 'package:gps_software/util/logger.dart';
import 'package:gps_software/util/user_details.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'logging_dio_interceptor.dart';

PackageInfo? packageInfo;

class ApiService {
  static final Dio _dio = Dio();
  String? packageName;

  ApiService() {
    _dio.options.baseUrl = ApiUrl.baseUrl;
    _dio.interceptors.add(LoggingDioInterceptor());
    _dio.interceptors.add(
      LogInterceptor(
        request: kDebugMode,
        error: kDebugMode,
        responseHeader: kDebugMode,
        requestBody: kDebugMode,
        requestHeader: kDebugMode,
        responseBody: kDebugMode,
      ),
    );
    if (kDebugMode) {
      packageName = packageInfo?.packageName ?? "";
    } else {
      packageName = packageInfo?.packageName ?? "";
    }
  }

  void updateBaseUrl() {
    _dio.options.baseUrl = ApiUrl.baseUrl;
  }

  Future<void> postMultipartRequest({
    required String url,
    required Map<String, dynamic> fields,
    Map<String, dynamic>? files, // key: field name, value: file path
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      dio.FormData formData = dio.FormData();

      /// Add normal fields
      fields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      /// Add files
      if (files != null) {
        for (var entry in files.entries) {
          formData.files.add(
            MapEntry(
              entry.key,
              await dio.MultipartFile.fromFile(entry.value),
            ),
          );
        }
      }

      final token = (await UserDetails().getSaveUserDetails).userData?.token;

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
          contentType: "multipart/form-data",
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess({"response": response.data});
      } else {
        onError(response.data['message'] ?? "Something went wrong");
      }
    } on DioException catch (e) {
      onError(e.response?.data['message'] ?? e.message ?? "Error");
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> postRequest({
    required String url,
    dynamic params,
    dynamic header,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String) onError,
    bool isBinary = false,
  }) async {
    try {
      final token = (await UserDetails().getSaveUserDetails).userData?.token;
      logPrint('Method => POST , API URL ==> $url');
      logPrint('Params ==> $params');
      logPrint('token ==> $token');

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        "appId": packageName,
        "versionName": packageInfo?.version,
        "versionCode": packageInfo?.buildNumber,
      };
      if (header != null) {
        headers.addAll(header);
      }
      _dio.options.headers.addAll(headers);
      Map<String, dynamic> tempParams = {};
      if (params != null) {
        if (params is dio.FormData) {
          params.fields.forEach((MapEntry<String, String> element) {
            tempParams[element.key] = element.value;
          });
          params.files.forEach((element) {
            tempParams[element.key] = element.value;
          });
        } else {
          tempParams.addAll(params);
        }
      }
      log('Params ==>456  ${headers}  ${tempParams}');
      var response = await _dio.post(
        url,
        data: params is dio.FormData
            ? dio.FormData.fromMap(tempParams)
            : tempParams,
        options: dio.Options(
          responseType: isBinary
              ? dio.ResponseType.bytes
              : dio.ResponseType.json,
        ),
      );
      logger("response  ===>  11 ${jsonEncode(response.data)}");
      if (response.statusCode != 200 && response.statusCode != 201) {
        onError(response.data['message']);
      } else {
        response.data.runtimeType;
        if (response.data is Map) {
          if (response.data["success"] != null) {
            if (response.data["success"] == false) {
              onError(response.data['error'] ?? response.data['message']);
              return;
            }
          }
        }
        Map<String, dynamic> data = Map();
        data["response"] = response.data;
        onSuccess(data);
      }
    } on DioException catch (e) {
      logPrint('Error  ===>  $e  ${e.response}  ${e.type}');
      if (e.type == DioExceptionType.unknown) {
        logPrint('Error  ===>    ${e.type}');
        onError(e.message ?? "");
      }
      if (e.response != null) {
        logPrint('Error  ===>  ${e.response?.data}  ${e.type}');
        onError(e.response?.data['message'] ?? e.response?.data['error']);
      }
    } catch (e) {
      logger("msg ---$e");
      onError("$e");
    }
    return;
  }

  Future<void> getRequest({
    required String url,
    Map<String, dynamic>? header,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String?) onError,
  }) async {
    try {
      final token = (await UserDetails().getSaveUserDetails).userData?.token;
      logPrint('Method => GET , API URL ==> $url');
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        "appId": packageName,
        "versionName": packageInfo?.version,
        "versionCode": packageInfo?.buildNumber,
      };
      if (header != null) {
        _dio.options.headers.addAll(header);
      } else {
        _dio.options.headers.addAll(headers);
      }
      printCurlCommand(Uri.parse(url), _dio.options.headers);

      var response = await _dio.get(url);

      log('response  ===>  ===${response.statusCode}===${response}');
      if (response.statusCode != 200) {
        onError(response.data['message']);
        logger("statusCode  - -  -${response.statusCode}");
      } else {
        Map<String, dynamic> data = Map();
        data["response"] = response.data;
        onSuccess(data);
      }
    } on DioException catch (e) {
      logPrint('Error 12 ===>  $e    ${e.type}');
      if (e.response?.statusCode == 401) {
        Get.offAllNamed("/");
      }
      if (e.type == DioExceptionType.unknown) {
        onError(null);
      }
      if (e.response != null) {
        logPrint('Error12  ===>  ${e.response?.data}');
        onError(e.response?.data['message'] ?? e.response?.data["error"]);
      }
    } catch (e) {
      onError("$e");
    }
    return;
  }

  void printCurlCommand(Uri url, Map<String, dynamic> headers) {
    String curlCommand = "curl -X GET '$url'";

    if (headers != null && headers.isNotEmpty) {
      headers.forEach((key, value) {
        curlCommand += " -H '$key: $value'";
      });
    }

    print("cURL Command: $curlCommand");
  }

  Future<void> deleteRequest({
    required String url,
    Map<String, dynamic>? header,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String?) onError,
  }) async {
    try {
      final token = (await UserDetails().getSaveUserDetails).userData?.token;
      logPrint('Method => DELETE , API URL ==> $url');
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        "appId": packageName,
        "versionName": packageInfo?.version,
        "versionCode": packageInfo?.buildNumber,
      };
      if (header != null) {
        _dio.options.headers.addAll(header);
      } else {
        _dio.options.headers.addAll(headers);
      }
      var response = await _dio.delete(url);
      log('response  ===>  $response');
      if (response.statusCode != 200) {
        onError(response.data['message']);
      } else {
        if (response.data is HashMap) {
          if (response.data["status"] != null) {
            if (response.data["status"] == false) {
              onError(response.data['message']);
              return;
            }
          }
        }
        Map<String, dynamic> data = Map();
        data["response"] = response.data;
        onSuccess(data);
      }
    } on DioException catch (e) {
      logPrint('Error 12 ===>  $e    ${e.type}');
      if (e.type == DioExceptionType.unknown) {
        onError(null);
      }
      if (e.response != null) {
        logPrint('Error12  ===>  ${e.response?.data}');
        onError(e.response?.data['message'] ?? e.response?.data["error"]);
      }
    } catch (e) {
      onError("$e");
    }
    return;
  }

  Future<void> putRequest({
    required String url,
    dynamic params,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String?) onError,
  }) async {
    try {
      final token = (await UserDetails().getSaveUserDetails).userData?.token;
      logPrint('Method => PUT , API URL ==> $url');
      logPrint('Params ==> $params');
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        "appId": packageName,
        "versionName": packageInfo?.version,
        "versionCode": packageInfo?.buildNumber,
      };
      _dio.options.headers.addAll(headers);
      var response = await _dio.put(url, data: params);
      logger("response   ===>   $response");
      onSuccess(json.decode(response.toString()));
    } on DioException catch (e) {
      logPrint('Error 12 ===>  $e    ${e.type}');
      if (e.type == DioExceptionType.unknown) {
        onError(null);
      }
      if (e.response != null) {
        logPrint('Error12  ===>  ${e.response?.data}');
        onError(e.response?.data['message']);
      }
    } catch (e) {
      onError("$e");
    }
    return;
  }
}

ApiService apiService = ApiService();
