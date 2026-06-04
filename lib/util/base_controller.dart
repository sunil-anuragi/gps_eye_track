import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/logger.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BaseController extends GetxController {
  static bool isLoaderShow = false;
  DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat dateFormatAmPm = DateFormat('HH:mm a');
  DateFormat dateFormatutc = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'");
  DateFormat dateFormat12AmPm = DateFormat('hh:mm a');
  DateFormat dateMonthFormat = DateFormat('dd MMM');

  void showLoader() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    if (!isLoaderShow) {
      isLoaderShow = true;
      Get.dialog(
        WillPopScope(
            onWillPop: () => Future.value(false),
            child: const Center(child: CircularProgressIndicator())),
        barrierDismissible: false,
      );
    }
  }

  String formatTime(String input) {
    List<String> parts = input.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    String formattedTime = '';

    if (hours > 0) {
      if (hours > 1) {
        formattedTime += '$hours Hours ';
      } else {
        formattedTime += '$hours Hour ';
      }
    }

    if (minutes > 0) {
      if (minutes > 1) {
        formattedTime += '$minutes Mins ';
      } else {
        formattedTime += '$minutes Min ';
      }
    }

    if (seconds > 0) {
      if (seconds > 1) {
        formattedTime += '$seconds Secs';
      } else {
        formattedTime += '$seconds Sec';
      }
    }

    return formattedTime.trim();
  }

  String formatTimeHrMins(String input) {
    List<String> parts = input.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    String formattedTime = '';

    if (hours > 0) {
      if (hours > 1) {
        formattedTime += '$hours Hrs ';
      } else {
        formattedTime += '$hours Hr ';
      }
    }

    if (minutes > 0) {
      if (minutes > 1) {
        formattedTime += '$minutes Mins ';
      } else {
        formattedTime += '$minutes Min ';
      }
    }
   // Show seconds ONLY when hours and minutes are 0
  if (hours == 0 && minutes == 0 && seconds > 0) {
    formattedTime += seconds > 1 ? '$seconds Secs' : '$seconds Sec';
  }

    return formattedTime.trim();
  }

  Future<void> dismissLoader() async {
    if (Get.isSnackbarOpen) {
      await Future.delayed(const Duration(seconds: 1));
      dismissLoader();
      return;
    }
    if (isLoaderShow) {
      isLoaderShow = false;
      if (Get.isSnackbarOpen) {
        Get.back();
      }
      Get.back();
    }
  }

  void showError(
      {String title = "Alert!", String? msg, bool isDialogNotDismiss = false}) {
    if (!isDialogNotDismiss) {
      dismissLoader();
    }
    if (msg != null) {
      // Get.snackbar(title.tr, msg,
      //     backgroundColor: Colors.redAccent.withOpacity(0.8),
      //     colorText: Colors.white);
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        timeInSecForIosWeb: 1,
      );
    }
  }

  void showSnack({String title = "Alert!", required String msg}) {
    dismissLoader();
    // Get.snackbar(
    //   title.tr,
    //   msg,
    //   backgroundColor: const Color(0xff098a09),
    //   colorText: Colors.white,
    // );
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  void removeUnFocusManager() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Future<Uint8List?> getBytesFromCanvas(String text) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = AppColors.redColor.withOpacity(0.65);
    final int size = 100; //change this according to your app
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
    painter.text = TextSpan(
      text: text, //you can write your own text here or take from parameter
      style: TextStyle(
          fontSize: size / 2, color: Colors.white, fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data?.buffer.asUint8List();
  }

  String getFileExtension(String url) {
    return url.split('.').last;
  }

  Future<void> downloadFiles(
      {required String url, required String fileName, String? token}) async {
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}",
      "X-Requested-With": "XMLHttpRequest",
    };
    Directory appDocDir;
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      int sdkVersion = androidInfo.version.sdkInt;
      logger("sdkVersion::${sdkVersion}");
      if (sdkVersion < 33) {
        await requestStoragePermission();
      }
    }
    if (Platform.isAndroid) {
      appDocDir = Directory('/storage/emulated/0/Download');
    } else {
      appDocDir = await getApplicationDocumentsDirectory();
    }
    print("url" + url.toString());
    await FlutterDownloader.enqueue(
        url: url,
        headers: headers,
        savedDir: appDocDir.path,
        showNotification: true,
        fileName: fileName,
        timeout: 100000,
        openFileFromNotification: true);
    Get.back();
  }

  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      int sdkVersion = androidInfo.version.sdkInt;

      logger("Android SDK Version: $sdkVersion");
      if (sdkVersion >= 33) {
        if (await Permission.photos.isDenied) {
          PermissionStatus status = await Permission.photos.request();

          if (status.isGranted) {
            logger("Permission Granted for images");
          } else {
            showError(msg: "Permission Denied for images");
          }
        }

        if (await Permission.videos.isDenied) {
          PermissionStatus status = await Permission.videos.request();

          if (status.isGranted) {
            logger("Permission Granted for videos");
          } else {
            showError(msg: "Permission Denied for videos");
          }
        }

        if (await Permission.audio.isDenied) {
          PermissionStatus status = await Permission.audio.request();

          if (status.isGranted) {
            logger("Permission Granted for audio");
          } else {
            showError(msg: "Permission Denied for audio");
          }
        }
      } else {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (status.isPermanentlyDenied) {
            await openAppSettings();
          } else if (!status.isGranted) {
            throw 'Storage permission not granted';
          }
        }
      }
    }
  }
}

class RxNullable<T> {
  Rx<T?> setNull() => (null as T?).obs;
}
