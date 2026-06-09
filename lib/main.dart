import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:gps_software/api/api_service.dart';
import 'package:gps_software/routes/pages.dart';
import 'package:gps_software/screens/bottomBar/model/all_trip_model.dart';
import 'package:gps_software/services/firebase_notification.dart';
import 'package:gps_software/translations/lang.dart';
import 'package:gps_software/util/app_constant.dart';
import 'package:gps_software/util/logger.dart';
import 'package:gps_software/util/user_details.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

String language = 'en';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("calling backhroud habdling");
  print("Handling a background message: ${message.messageId}");
  if (message.data["type"] == "safe_alert") {
    print("message data: ${message.data}");
    // localNotificationShow(message.data);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        "parking_alert", message.data["vehicle_data"] ?? "");
    alertVehicleModel.value = AllVehicle.fromJson(
      jsonDecode(message.data["vehicle_data"]),
    );
  } else if (message.data.isNotEmpty) {
    print("calling local notification");
    localNotificationShow(message.data);
  } else {
    print("calling not local notification");
  }
  debugPrint('Handling a background message ${message.messageId}');
}

@pragma('vm:entry-point')
Future<void> downloadCallback(String id, int status, int progress) async {
  final taskStatus = DownloadTaskStatus.values[status];

  if (taskStatus == DownloadTaskStatus.complete) {
    logger("Download completed for task ID: $id");
  } else if (taskStatus == DownloadTaskStatus.failed) {
    logger("Download failed for task ID: $id");
  } else {
    logger("Download task $id is $progress% complete.");
  }
}

FlutterTts? flutterTts;
UserDetails? _userDetails;

Future<void> localNotificationShow(Map<String, dynamic> data) async {
  try {
    logger("message.data - - --${data}");
    await flutterLocalNotificationsPlugin.cancelAll();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    _userDetails ??= UserDetails();
    bool isVoiceOn = (await _userDetails?.getVoiceNotificationOn) ?? false;
    logger("msg => aa $isVoiceOn");
    bool isVoice =
        ((bool.tryParse(data["isVoice"] ?? "") ?? false) && isVoiceOn);

    logger("msg => aa $isVoiceOn  $isVoice");
    String? title = data["title"];
    String? body = data["body"];
    String voiceMessage = data["voiceMessage"] ?? "";

    flutterLocalNotificationsPlugin.show(
      randomNumber,
      title,
      body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            isVoice ? voiceSound.id : channel.id,
            isVoice ? voiceSound.name : channel.name,
            importance: Importance.max,
            playSound: !isVoice,
            priority: Priority.high,
            fullScreenIntent: true,
            ticker: 'ticker',
            // priority: Priority.high,
            icon: "@mipmap/ic_notification",
            styleInformation: BigTextStyleInformation(
              (body ?? ""),
              htmlFormatBigText: true,
              contentTitle: title,
              htmlFormatContentTitle: true,
              htmlFormatTitle: true,
              htmlFormatContent: true,
            ),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          )),
    );
    RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;

    if (ringerStatus == RingerModeStatus.normal && isVoice) {
      flutterTts ??= FlutterTts();
      await flutterTts?.awaitSpeakCompletion(true);
      if (Platform.isAndroid) {
        var engine = await flutterTts?.getDefaultEngine;
        if (engine != null) {
          if (kDebugMode) {
            print(engine);
          }
        }
        var voice = await flutterTts?.getDefaultVoice;
        if (voice != null) {
          if (kDebugMode) {
            print(voice);
          }
        }
      }
      await flutterTts?.speak(voiceMessage);
    }
  } catch (e) {
    logger("msg ==>  $e");
  }
}

Future<void> showDownloadProgressNotification({
  required int id,
  required String title,
  required String body,
  required int progress,
}) async {
  final clamped = progress.clamp(0, 100);
  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.high,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: 100,
        progress: clamped,
        ongoing: clamped < 100,
        autoCancel: clamped >= 100,
        icon: "@mipmap/ic_notification",
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: false,
      ),
    ),
  );
}

Future<void> showDownloadCompletedNotification({
  required int id,
  required String title,
  required String body,
}) async {
  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.high,
        priority: Priority.high,
        onlyAlertOnce: true,
        ongoing: false,
        autoCancel: true,
        icon: "@mipmap/ic_notification",
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      ),
    ),
  );
}

Future<void> showDownloadFailedNotification({
  required int id,
  required String title,
  required String body,
}) async {
  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.high,
        priority: Priority.high,
        onlyAlertOnce: true,
        ongoing: false,
        autoCancel: true,
        icon: "@mipmap/ic_notification",
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      ),
    ),
  );
}

ValueNotifier<AllVehicle?> alertVehicleModel = ValueNotifier(null);

const AndroidNotificationChannel voiceSound = AndroidNotificationChannel(
  'Voice notification', // id
  'Voice Notification', // title
  importance: Importance.high,
  playSound: false,
);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'app notification', // id
  'App Related Notification', // title
  importance: Importance.high,
  playSound: true,
);

const AndroidNotificationChannel alarmChannel = AndroidNotificationChannel(
    'alarm_tone', // id
    'Alarm', // title
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound("alarm_tone"),
    playSound: true);

const AndroidNotificationChannel ignOnChannel = AndroidNotificationChannel(
    'ign_on', // id
    'Ignition On', // title
    sound: RawResourceAndroidNotificationSound("ign_on"),
    importance: Importance.high,
    playSound: false);

const AndroidNotificationChannel ignOffChannel = AndroidNotificationChannel(
    'ign_off', // id
    sound: RawResourceAndroidNotificationSound("ign_off"),
    'Ignition Off', // title
    importance: Importance.high,
    playSound: true);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseNotification fn = FirebaseNotification();
  await fn.initFirebase();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(alarmChannel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(ignOnChannel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(ignOffChannel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  packageInfo = await PackageInfo.fromPlatform();
  final UserDetails userDetails = UserDetails();
  await userDetails.getLanguage.then((value) {
    return language = value;
  });
  // final GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   mapsImplementation.useAndroidViewSurface = true;
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     initializeMapRenderer();
  //   });
  // }
  await dotenv.load(fileName: ".env");
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FlutterDownloader.registerCallback(downloadCallback);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, AndroidNotificationChannel> _channelMap = {};
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    FirebaseNotification().getFirebaseToken().then((value) {
      logger("Firebase Token: $value");
    });
    _checkIntent();

    _channelMap[alarmChannel.id] = alarmChannel;
    _channelMap[ignOnChannel.id] = ignOnChannel;
    _channelMap[ignOffChannel.id] = ignOffChannel;

    var android = const AndroidInitializationSettings('mipmap/ic_notification');
    var ios = const DarwinInitializationSettings();
    var platform = InitializationSettings(android: android, iOS: ios);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      flutterLocalNotificationsPlugin.initialize(platform);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("on message ======>>>>call");
        logger("message.data - - --${message.data}");
        print("message.data - - --${message.data}");
        if (message.data["type"] == "safe_alert") {
          if (message.data["vehicle_data"] != null) {
            alertVehicleModel.value = AllVehicle.fromJson(
              jsonDecode(message.data["vehicle_data"]),
            );
          }
          return;
        }
        localNotificationShow(message.data);
      });
      await flutterTts.awaitSpeakCompletion(true);
      if (Platform.isAndroid) {
        var engine = await flutterTts.getDefaultEngine;
        if (engine != null) {
          print(engine);
        }

        var voice = await flutterTts.getDefaultVoice;
        if (voice != null) {
          print(voice);
        }
      }
    });
  }

  void _checkIntent() async {
    const MethodChannel channel =
        MethodChannel('com.gpssoftware/alert');
    try {
      final result = await channel.invokeMethod('getSafeAlert');
      print("resy;ut" + result.toString());
      if (result == 'true') {
        print("🔥 Safe Alert Received - Launch Alarm Screen");
        // alertVehicleModel.value = AllVehicle.fromJson(
        //   jsonDecode(message.data["vehicle_data"]),
        // );
      }
    } catch (e) {
      print("No safe_alert intent.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          locale: Locale(language),
          fallbackLocale: const Locale(
            'gu',
            'hi',
          ),
          translations: Lang(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColorShades),
              useMaterial3: true,
              primarySwatch: AppColors.primaryColorShades,
              scaffoldBackgroundColor: Colors.white),
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL,
          builder: (context, child) {
            return SafeArea(
              top: false,
              bottom: true,
              child: child!,
            );
          },
        );
      },
    );
  }
}
