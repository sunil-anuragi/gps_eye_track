import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gps_software/util/logger.dart';

class FirebaseNotification {
  static RemoteMessage? remoteMessage;

  initFirebase() async {
    await setUpPermissions();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static setUpPermissions() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String?> getFirebaseToken() async {
    logger("Get Token");

    String? token = await FirebaseMessaging.instance.getToken();
    logger("Fcm Token:::$token");

    return token;
  }

  updateFirebaseToken() async {
    // String? token = await FirebaseMessaging.instance.getToken();
  }

  onNotificationClickEvent() async {}
}
