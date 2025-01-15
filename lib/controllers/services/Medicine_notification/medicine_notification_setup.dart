import 'package:flutter/material.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_manager.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_model.dart';

abstract class AdhanNotificationSetupAbstract {
  Future<bool> setNotificationIfConditionsMetMedi(BuildContext context);
}

class AdhanNotificationSetup implements AdhanNotificationSetupAbstract {
  setNotificationForMedicine(
    BuildContext context,
    int id,
    String name,
    dynamic takingTime,
    dynamic note,
    DateTime time,
    bool status,
  ) async {
    MedicineReminderModel().initialization(id, name, takingTime, note, time, status);
    MedicineNotificationManager notificationManagerForMedicine = MedicineNotificationManager();
    notificationManagerForMedicine.initialise(context);

    // notificationManager.cancelNotification();
    for (var medicinereminder in MedicineReminderModel().medicineReminders) {
      notificationManagerForMedicine.setNotification(
        time: medicinereminder.time,
        id: medicinereminder.id,
        name: medicinereminder.medicneName,
        tekingTime: medicinereminder.takeTime,
      );
    }
  }

  @override
  Future<bool> setNotificationIfConditionsMetMedi(BuildContext context) {
    throw UnimplementedError();
  }
}
