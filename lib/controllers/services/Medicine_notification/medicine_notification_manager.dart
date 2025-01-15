// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_model.dart';
import 'package:muslim_vision/views/pages/medicine_alert_screen/daily_alart_view_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginForMedicine = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('icon');
const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

class MedicineNotificationManager {
  initialise(BuildContext context) async {
    selectNotfication(NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        try {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DailyAlartViewScreen()),
          );
        } catch (e) {
          debugPrint('Error parsing notification payload: $e');
        }
        debugPrint('notification payload: $payload');
      }
      //
    }

    await flutterLocalNotificationsPluginForMedicine.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotfication,
    );
  }

  setNotification({required DateTime time, required int id, required String name, required String tekingTime}) async {
    tz.initializeTimeZones();
    Duration duration = time.difference(DateTime.now());
    debugPrint('Durtation -----------------------');

    if (!duration.isNegative) {
      final medicineReminder = MedicineReminder(
        id: id,
        medicneName: name,
        takeTime: tekingTime,
        time: time,
        note: 'Reminder Note', // Example note, adjust as needed
      );
      await flutterLocalNotificationsPluginForMedicine.zonedSchedule(
          id,
          name,
          tekingTime,
          tz.TZDateTime.now(tz.local).add(duration),
          NotificationDetails(
            android: AndroidNotificationDetails(
                id.toString(),
                // make sure to change this channel id during build apk
                'Muslim Vision',
                channelDescription: 'Notification for Medicine',
                fullScreenIntent: false,
                autoCancel: true,
                audioAttributesUsage: AudioAttributesUsage.alarm,
                importance: Importance.max,
                priority: Priority.max,
                playSound: true,
                color: const Color(0xff00a486),
                sound: const RawResourceAndroidNotificationSound("alarm"),
                styleInformation: BigTextStyleInformation(tekingTime)),
          ),
          payload: medicineReminder.toPayload(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future cancelAllMedicineNotification() async {
    final pendingNotification = await flutterLocalNotificationsPluginForMedicine.pendingNotificationRequests();
    for (var pn in pendingNotification) {
      if (pn.payload != 'Adhan is going') {
        flutterLocalNotificationsPluginForMedicine.cancel(pn.id);
      }
    }
  }

  static Future<void> cancelIndividualNotification(String medicineName, DateTime time) async {
    final pendingNotification = await flutterLocalNotificationsPluginForMedicine.pendingNotificationRequests();
    final matchingNotifications = pendingNotification.where((element) {
      try {
        final payload = element.payload;
        if (payload == null || payload == 'Adhan is going') return false;
        // debugPrint('${element.payload}bnklfghkgnh');

        final medicineNotification = MedicineReminder.fromPayload(payload);
        return medicineNotification.medicneName == medicineName && medicineNotification.time.hour == time.hour && medicineNotification.time.minute == time.minute;
      } catch (e) {
        // Log the error and ignore this notification
        debugPrint('Failed to parse notification payload: $e');
        return false;
      }
    }).toList();
    for (var notification in matchingNotifications) {
      await flutterLocalNotificationsPluginForMedicine.cancel(notification.id);
    }
  }
}
