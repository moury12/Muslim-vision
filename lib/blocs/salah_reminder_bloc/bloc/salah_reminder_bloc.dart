// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/models/salah_reminder_model.dart';

import '../../../controllers/services/adhan_notification/adhan_notification_setup.dart';

part 'salah_reminder_event.dart';
part 'salah_reminder_state.dart';

class SalahReminderBloc extends Bloc<SalahReminderEvent, SalahReminderState> {

  SalahReminderBloc() : super(SalahReminderInitial()) {
    final salahReminderBox = Boxes().salahReminderBox;
    Map<int, SalahReminderModel> modifiedMap = {};
    final initialSalahReminderMap = {
      1: SalahReminderModel(id: 1, waqtName: 'Fajr', isEnabled:true).toJson(),
      2: SalahReminderModel(id: 2, waqtName: 'Duhur', isEnabled: true).toJson(),
      3: SalahReminderModel(id: 3, waqtName: 'Asr', isEnabled: true).toJson(),
      4: SalahReminderModel(id: 4, waqtName: 'Maghrib', isEnabled: true).toJson(),
      5: SalahReminderModel(id: 5, waqtName: 'Isha', isEnabled: true).toJson(),
      6: SalahReminderModel(id: 6, waqtName: 'Tahajjud', isEnabled: true).toJson()
    };

    Map<int, SalahReminderModel> formatSalahReminderModelFromHive(dynamic map) {
      return {1: SalahReminderModel.fromJson(map[1]), 2: SalahReminderModel.fromJson(map[2]), 3: SalahReminderModel.fromJson(map[3]), 4: SalahReminderModel.fromJson(map[4]), 5: SalahReminderModel.fromJson(map[5]), 6: SalahReminderModel.fromJson(map[6])};
    }

    Map<int, SalahReminderModel> getFormatedSalahReminderModelFromHive() {
      final salaReminderMapFromHive = salahReminderBox.get('salahReminderMap');

      final savedSalahReminderMap = formatSalahReminderModelFromHive(salaReminderMapFromHive);

      return savedSalahReminderMap;
    }

    on<SalahReminderLoadedEvent>((event, emit) async {
      // Fetch the latest Azan notification status from Hive
      bool isAzanOn = Boxes().utilsBox.get('azan_notification', defaultValue: true);

      if (salahReminderBox.keys.isEmpty) {
        // If the box is empty, initialize it with default values
        await salahReminderBox.put('salahReminderMap', initialSalahReminderMap);
        final savedSalahReminderMap = getFormatedSalahReminderModelFromHive();
        modifiedMap = savedSalahReminderMap;

        emit(SalahReminderLoadedState(salahReminderMap: savedSalahReminderMap));
      } else {
        // Retrieve the existing map from Hive
        final savedSalahReminderMap = getFormatedSalahReminderModelFromHive();

        // Update the `isEnabled` property based on `isAzanOn`
        for (var key in savedSalahReminderMap.keys) {
          savedSalahReminderMap[key]!.isEnabled = isAzanOn;
        }

        // Save the updated map back to Hive
        await salahReminderBox.put(
          'salahReminderMap',
          savedSalahReminderMap.map((key, value) => MapEntry(key, value.toJson())),
        );

        print('Updated isAzanOn: $isAzanOn');
        print('Updated savedSalahReminderMap: ${savedSalahReminderMap.values}');

        // Emit the updated state
        emit(SalahReminderLoadedState(salahReminderMap: savedSalahReminderMap));
      }
    });


    on<SalahReminderEditEvent>((event, emit) async {
      bool isAzanOn=  Boxes().utilsBox.get('azan_notification',defaultValue: true);


      modifiedMap = event.salahReminderMap;
      emit(SalahReminderLoadedState(salahReminderMap: event.salahReminderMap));
    });

    on<SalahReminderSaveEvent>((event, emit) async {
      final BuildContext context = event.context;
      final updatedMap = {1: modifiedMap[1]!.toJson(), 2: modifiedMap[2]!.toJson(), 3: modifiedMap[3]!.toJson(), 4: modifiedMap[4]!.toJson(), 5: modifiedMap[5]!.toJson(), 6: modifiedMap[6]!.toJson()};

      /// set notification for next 7 days
      await salahReminderBox.put('salahReminderMap', updatedMap);
      if (context.mounted&&Boxes().utilsBox.get('azan_notification',defaultValue: true)) {
        AdhanNotificationSetup().setNotificationIfConditionsMet(context);
        emit(SalahReminderNotificationSuccessState(msg: 'alarm_set_for_next_7_days'.tr()));
      }
    });
  }
}
