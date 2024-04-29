import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../firebase_options.dart';
import '../app_theme/app_colors.dart';
import '../utils/storage_utils.dart';
import 'app_services.dart';
import 'notification_services.dart';

StreamController<dynamic> appClosednotificationController =
    StreamController<dynamic>.broadcast();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'custom_notification_channel_id',
  'Notification',
  description: 'notifications from Your App Name.',
  importance: Importance.high,
);

Future<void> initializeFireBase() async {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  await setupFcm();
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init(StorageKeys.containerKey);

  /// Initializes the Firebase app with the provided options.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Get.putAsync<AppService>(() => AppService().init());

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification == null) {
    showNotification(
        hashCode: notification.hashCode,
        title: message.data["title"],
        body: message.data["body"],
        payload: json.encode({
          "data": message.data,
          "name": message.data["body"]?.split(" ").first
        }),
        valueType: message.data["ValueType"]);
  }
}

Future onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) async {
  debugPrint(
      "FirebaseMessaging.initialize onDidReceiveBackgroundNotificationResponse");
}

void _checkListnerAndSendEvent(
    StreamController<dynamic> controller, int tryingNumber, String payload) {
  if (tryingNumber >= 6) {
    return;
  }

  print("controller.hasListener-- ${controller.hasListener}");

  if (controller.hasListener == true) {
    controller.add(payload);
    return;
  } else {
    Future.delayed(const Duration(seconds: 2), () async {
      _checkListnerAndSendEvent(controller, tryingNumber + 1, payload);
    });
  }
}

Future<void> setupFcm() async {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOs = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOs,
  );

  //when the app is in foreground state and you click on notification.
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      debugPrint(
          "FirebaseMessaging.initialize onDidReceiveNotificationResponse");
      debugPrint(
          "FirebaseMessaging.initialize onDidReceiveNotificationResponse manage click ${notificationResponse.payload}");

      NotificationService.instance.redirect(notificationResponse.payload);
    },
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
  );

  /// Commented as now handled from splash screen
  /// -----------------------------------------
  // //When the app is terminated, i.e., app is neither in foreground or background.
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   //Its compulsory to check if RemoteMessage instance is null or not.

  //   if (message != null) {
  //     // showToast("getInitialMessage ${message.data}");
  //     debugPrint("FirebaseMessaging FirebaseMessaging.instance");
  //     // Future.delayed(const Duration(milliseconds: 200),() {
  //     //   NotificationService.instance.redirect(jsonEncode({"data" : message.data, "name" : message.notification?.body?.split(" ").first}));
  //     // },);
  //     AppUtility.showSnackBar(message: message.toString());

  //     String payload = jsonEncode({
  //       "data": message.data,
  //       "name": message.notification?.body?.split(" ").first
  //     });
  //     _checkListnerAndSendEvent(appClosednotificationController, 0, payload);
  //     // if (appClosednotificationController.hasListener == true) {
  //     //   appClosednotificationController.add(jsonEncode({"data" : message.data, "name" : message.notification?.body?.split(" ").first}));
  //     //   return;
  //     // }
  //   }
  // });

  //When the app is in the background, but not terminated.
  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) {
      debugPrint(
          "FirebaseMessaging FirebaseMessaging.onMessageOpenedApp event");
      debugPrint(
          "FirebaseMessaging FirebaseMessaging.onMessageOpenedApp event ${event.data}");
      // showToast("onMessageOpenedApp ${event.data}");

      NotificationService.instance.redirect(jsonEncode({
        "data": event.data,
        "name": event.notification?.body?.split(" ").first
      }));
      // NotificationService.instance.redirect(jsonEncode(event.data));
    },
    cancelOnError: false,
    onDone: () {
      debugPrint(
          "FirebaseMessaging FirebaseMessaging.onMessageOpenedApp onDone");
    },
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    debugPrint("onMessage messageId ${message.messageId}");
    if (notification != null && android != null) {

      if (android.imageUrl != null && android.imageUrl!.trim().isNotEmpty) {
        showNotification(
            hashCode: notification.hashCode,
            title: notification.title,
            body: notification.body,
            payload: json.encode({
              "data": message.data,
              "name": notification.body?.split(" ").first
            }),
            valueType: message.data["ValueType"] ?? "");
      } else {
        debugPrint("notification ${message.data}");
        showNotification(
            hashCode: notification.hashCode,
            title: notification.title,
            body: notification.body,
            payload: json.encode({
              "data": message.data,
              "name": notification.body?.split(" ").first
            }),
            valueType: message.data["ValueType"] ?? "");
      }
    } else {
      debugPrint("notification ${message.data}");

      if (message.data.isEmpty) {
        return;
      }
      showNotification(
          hashCode: notification.hashCode,
          title: message.data["title"],
          body: message.data["body"],
          payload: json.encode({
            "data": message.data,
            "name": message.data["body"]?.split(" ").first
          }),
          valueType: message.data["ValueType"]);
    }
  });
}

void showNotification({
  required int hashCode,
  required String? title,
  required String? valueType,
  required String? body,
  required String? payload,
}) {
  flutterLocalNotificationsPlugin.show(
    hashCode,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: '@drawable/notification_icon',
        color: AppColors.notificationBackgroundColor,
        importance: Importance.max,
        priority: Priority.high,
        // largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
        // styleInformation: bigPictureStyleInformation,
      ),
        iOS : DarwinNotificationDetails(
          threadIdentifier: DateTime.now().millisecondsSinceEpoch.toString(),
          presentSound: true,
          presentAlert: true,
          presentBanner: true,
        )
    ),
    payload: payload,
    // payload: json.encode(message.data),
  );
}
