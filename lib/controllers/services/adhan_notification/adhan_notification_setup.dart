import 'package:flutter/material.dart';
import 'package:muslim_vision/controllers/services/adhan_notification/adhan_notification_manager.dart';
import 'package:muslim_vision/controllers/services/adhan_notification/adhan_notification_model.dart';
import 'package:muslim_vision/database/boxes.dart';

import '../../../models/salah_reminder_model.dart';

abstract class AdhanNotificationSetupAbstract {
  Future<bool> setNotificationIfConditionsMet(BuildContext context);
}

class AdhanNotificationSetup implements AdhanNotificationSetupAbstract {
  final adhanNotificationBox = Boxes().adhanNotificationBox;
  final utilsBox = Boxes().utilsBox;

_setCurrentLocationForAdhan() async {
    await adhanNotificationBox.put('lat', utilsBox.get('lat'));
    await adhanNotificationBox.put('long', utilsBox.get('long'));
  }

  Map<int, SalahReminderModel> _formatSalahReminderModelFromHive(dynamic map) {
    return {1: SalahReminderModel.fromJson(map[1]), 2: SalahReminderModel.fromJson(map[2]), 3: SalahReminderModel.fromJson(map[3]), 4: SalahReminderModel.fromJson(map[4]), 5: SalahReminderModel.fromJson(map[5]), 6: SalahReminderModel.fromJson(map[6])};
  }

  Map<int, SalahReminderModel> _getFormatedSalahReminderModelFromHive() {
    final salahReminderBox = Boxes().salahReminderBox;
    final salaReminderMapFromHive = salahReminderBox.get('salahReminderMap');
    final savedSalahReminderMap = _formatSalahReminderModelFromHive(salaReminderMapFromHive);

    return savedSalahReminderMap;
  }

  _setNotificationForAdhan(BuildContext context) async {
    final lat = adhanNotificationBox.get('lat');
    final long = adhanNotificationBox.get('long');
    AdhanReminders adhanReminders = AdhanReminders(
        lat: lat,
        long: long,
        adhanForAsr: const AdhanForWakto(adhanName: 'azan'),
        adhanForDhuhr: const AdhanForWakto(adhanName: 'azan'),
        adhanForIsha: const AdhanForWakto(adhanName: 'azan'),
        adhanForFajr: const AdhanForWakto(adhanName: "fazar_azan"),
        adhanForMaghrib: const AdhanForWakto(adhanName: "azan"));

    //------------------- if user wants to disable alarm for any waqt -----------------------
    final salahReminderBox = Boxes().salahReminderBox;
    if (salahReminderBox.keys.isNotEmpty) {
      final savedSalahReminder = _getFormatedSalahReminderModelFromHive();
      adhanReminders = AdhanReminders(
        lat: lat,
        long: long,
        adhanForAsr: AdhanForWakto(adhanName: 'azan', isAdhanOn: savedSalahReminder[3]!.isEnabled),
        adhanForDhuhr: AdhanForWakto(adhanName: 'azan', isAdhanOn: savedSalahReminder[2]!.isEnabled),
        adhanForIsha: AdhanForWakto(adhanName: 'azan', isAdhanOn: savedSalahReminder[5]!.isEnabled),
        adhanForFajr: AdhanForWakto(adhanName: "fazar_azan", isAdhanOn: savedSalahReminder[1]!.isEnabled),
        adhanForMaghrib: AdhanForWakto(adhanName: "azan", isAdhanOn: savedSalahReminder[4]!.isEnabled),
      );
    }

    //------------------- if user wants to disable alarm for any waqt -----------------------

    adhanReminders.initialization();
    NotificationManager notificationManager = NotificationManager();
    notificationManager.initialise(context);
    notificationManager.cancelNotification();
    for (var adhanReminder in adhanReminders.adhanReminders) {
      notificationManager.setNotification(time: adhanReminder.time, id: adhanReminder.id, wakto: adhanReminder.wakto, azanName: adhanReminder.adhan, waktoDescription: adhanReminder.waktoDescription);
    }
  }

  _setStartAndEndTimeForAdhan() async {
    await adhanNotificationBox.put('startDate', DateTime.now().toString());
    await adhanNotificationBox.put('endDate', DateTime.now().add(const Duration(days: 10)).toString());
  }

  @override
  Future<bool> setNotificationIfConditionsMet(BuildContext context) async {
    // // Check if the utility box is empty, if so, return false
    // if (utilsBox.keys.isEmpty) {
    //   return false;
    // }

    // // Check if the adhan notification box is empty
    // if (adhanNotificationBox.keys.isEmpty) {
    //   // If empty, set current location for adhan, start and end times, and set notification
    //   await _setCurrentLocationForAdhan();
    //   await _setStartAndEndTimeForAdhan();

    //   // Check if the widget is still mounted before setting the notification
    //   if (context.mounted) {
    //     await _setNotificationForAdhan(context);
    //   }

    //   // Return true to indicate successful notification setting
    //   return true;
    // }

    // // Retrieve latitude and longitude from the adhan notification box
    // final latInAdhanBox = adhanNotificationBox.get('lat');
    // final longInAdhanBox = adhanNotificationBox.get('long');

    // // Check if the utils location matches the location stored in the adhan notification box
    // final isLocationMatched = utilsBox.get('lat') == latInAdhanBox &&
    //     utilsBox.get('long') == longInAdhanBox;

    // // Retrieve the end time from the adhan notification box
    // final endDateInAdhanBox =
    //     DateTime.parse(adhanNotificationBox.get('endDate'));

    // // Check if the end date is before the current time
    // final isEndTimeBeforeToday = endDateInAdhanBox.isBefore(DateTime.now());

    // // If location and end time match, return false
    // if (isLocationMatched && isEndTimeBeforeToday) {
    //   return false;
    // }

    // If not, set current location for adhan, start and end times, and set notification
    await _setCurrentLocationForAdhan();
    await _setStartAndEndTimeForAdhan();

    // Check if the widget is still mounted before setting the notification
    if (context.mounted) {
      await _setNotificationForAdhan(context);
    }

    // Return true to indicate successful notification setting
    return true;
  }
}
