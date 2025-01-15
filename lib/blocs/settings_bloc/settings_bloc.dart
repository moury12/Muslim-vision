import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:muslim_vision/controllers/services/adhan_notification/adhan_notification_manager.dart';

import 'package:muslim_vision/database/boxes.dart';

import '../../controllers/services/adhan_notification/adhan_notification_setup.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  SettingsBloc() : super(AzanNotificationState(azanStatus:  Boxes().utilsBox.get('azan_notification',defaultValue: true))) {
    on<TurnAzanOffEvent>((event, emit) async{
       emit(SettingsLoadingState());
      Boxes().utilsBox.put('azan_notification', event.toggleValue,);
      if(!Boxes().utilsBox.get('azan_notification',defaultValue: true)){
       await NotificationManager().cancelNotification();
      }else{
      await AdhanNotificationSetup().setNotificationIfConditionsMet(event.context);
      }
      print('object');
      print(Boxes().utilsBox.get('azan_notification',defaultValue: true));
      emit(AzanNotificationState(azanStatus: Boxes().utilsBox.get('azan_notification',defaultValue: true)));

    });
  }
}
