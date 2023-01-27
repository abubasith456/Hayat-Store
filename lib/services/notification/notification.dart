import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class NotificationService {
  static Future initializeNotification(
      void Function(String? value) callBack) async {
    //Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    //iOS initialization
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: ((id, title, body, payload) {
              print("IOS notificatiom" + body!);
            }));

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: callBack);
  }

  static void pushNotification({
    required dynamic id,
    required String title,
    required dynamic body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("0", "hayat",
            importance: Importance.max, priority: Priority.max);
    IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(threadIdentifier: "thread1");

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
}
