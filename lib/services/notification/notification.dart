import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class NotificationService {

  static void pushNotification({
    required dynamic id,
    required String title,
    required dynamic body,
  }) async {



const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '0',
      'hayat',
      channelDescription: 'Yummy',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryText,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(id++, title,
        body, notificationDetails,
        payload: 'item x');
  }
}
