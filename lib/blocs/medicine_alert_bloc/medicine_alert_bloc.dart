import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_manager.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_model.dart';
import 'package:muslim_vision/database/boxes.dart';
part 'medicine_alert_event.dart';
part 'medicine_alert_state.dart';

class MedicineAlertBloc extends Bloc<MedicineAlertEvent, MedicineAlertState> {
  final Box _box = Boxes().medicineBox;
  MedicineAlertBloc() : super(MedicinesLoadedState(medicineReminderModel: [])) {
    on<LoadMedicineEvent>((event, emit) {
      final medicines = _box.values.map((e) => MedicineReminder.fromJson(Map<String, dynamic>.from(e))).toList();
      debugPrint(medicines.toList().toString());
      emit(MedicinesLoadedState(medicineReminderModel: medicines));
    });
    on<AddMedicine>(
      (event, emit) async {
        try {
          await _box.add(event.medicineReminder.toJson());
          // print('0000000000000000000');
          // print(_box.values);
          add(LoadMedicineEvent()); // Reload the data after adding new medicine
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
    on<DeleteMedicine>((event, emit) async {
      try {
        final medicineToDelete = _box.keys.cast<int>().where((element) {
          final reminder = MedicineReminder.fromJson(Map<String, dynamic>.from(_box.get(element)!));
          return reminder.medicneName == event.medicineName && reminder.time.hour == event.time.hour && reminder.time.minute == event.time.minute;
        }
            /*MedicineReminder.fromJson(Map<String,dynamic>.from(_box.get(element)!)).id==event.id,
       orElse: () => throw Exception('Error'),*/
            ).toList();
        for (var id in medicineToDelete) {
          debugPrint('jsonEncode(medicineToDelete)');
          debugPrint(jsonEncode(medicineToDelete));
          await _box.delete(id);
        }
        MedicineNotificationManager.cancelIndividualNotification(event.medicineName, event.time);
        add(LoadMedicineEvent()); // Refresh the list
      } catch (e) {
        debugPrint(e.toString()); // Emit error state
      }
    });
    on<DeleteAllMedicine>(
      (event, emit) async {
        try {
          await Boxes().medicineBox.clear();
          debugPrint('///////${Boxes().medicineBox.values}');
          // add(LoadMedicineEvent());
          // medicines.clear();
          emit(MedicinesLoadedState(medicineReminderModel: []));
          MedicineNotificationManager().cancelAllMedicineNotification();
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
    // add(LoadMedicineEvent());
  }
}
