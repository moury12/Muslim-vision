// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:muslim_vision/splash_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('icon');

const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

class NotificationManager {
  initialise(BuildContext context) async {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    selectNotfication(NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        debugPrint('notification payload: $payload');
      }
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotfication,
    );
  }

  setNotification({required DateTime time, required int id, required String wakto, required String azanName, required String waktoDescription}) async {
    tz.initializeTimeZones();
    Duration duration = time.difference(DateTime.now());
    // debugPrint("99999999999999999");
    // debugPrint(time.toString());
    // debugPrint(azanName.toString());
    if (!duration.isNegative) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          wakto,
          waktoDescription,
          tz.TZDateTime.now(tz.local).add(duration),
          NotificationDetails(
            android: AndroidNotificationDetails(
                '1', // make sure to change this channel id during build apk
                'Muslim Vision',
                channelDescription: 'Adhan for Prayer',
                fullScreenIntent: false,
                autoCancel: true,
                audioAttributesUsage: AudioAttributesUsage.alarm,
                importance: Importance.max,
                priority: Priority.max,
                playSound: true,
                color: const Color(0xff00a486),
                sound: RawResourceAndroidNotificationSound(azanName),
                styleInformation: BigTextStyleInformation(waktoDescription)),
          ),
          payload: 'Adhan is going',
          //don't change payload if you change it you need to change some condition for medicineNotificationManager
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future cancelNotification() async {
    final pendingNotification = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    log('Pending notifications before cancellation: ${pendingNotification.length}');
    for (var pn in pendingNotification) {
      if (pn.payload == 'Adhan is going') {
        await flutterLocalNotificationsPlugin.cancel(pn.id);
      }
    }
    log('Pending notifications after cancellation: ${pendingNotification.any((element) => element.payload=='Adhan is going')}');

  }
}
