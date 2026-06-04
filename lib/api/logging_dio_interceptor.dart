import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;
import 'package:gps_software/api/api.dart';
import 'package:gps_software/util/user_details.dart';
import '../util/logger.dart';

class LoggingDioInterceptor implements Interceptor {
  Dio dio = Dio();

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    logger(
        "message ==> response  $err ${err.response?.statusCode}    ${err.response?.data}");
    logger(
        "message ==> response  ${err.requestOptions.baseUrl}   123 ${err.requestOptions.uri}    ");
    if (err.response?.statusCode == 401) {
      if (!(err.response?.requestOptions.uri.toString() ?? "")
          .contains(ApiUrl.login)) {
        await UserDetails().logoutUser();
        getX.Get.offAllNamed("/");
      } else {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      logger(
          "message ==> response  $response ${response.statusCode}    ${response.data}");
    }
    if (response.statusCode == 401) {
      if (!(response.requestOptions.uri.toString()).contains(ApiUrl.login)) {
        await UserDetails().logoutUser();
        getX.Get.offAllNamed("/");
      } else {
        handler.next(response);
      }
    } else {
      handler.next(response);
    }
  }
}
