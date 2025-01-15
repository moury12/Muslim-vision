part of 'salah_reminder_bloc.dart';

@immutable
abstract class SalahReminderState {}

class SalahReminderInitial extends SalahReminderState {}

abstract class SalahReminderActionState extends SalahReminderState {}

class SalahReminderLoadedState extends SalahReminderState {
  final Map<int, SalahReminderModel> salahReminderMap;
  final bool? showSnackbar;
  SalahReminderLoadedState( {required this.salahReminderMap,this.showSnackbar=false});
}

class SalahReminderNotificationSuccessState extends SalahReminderActionState {
  final String msg;
  SalahReminderNotificationSuccessState({required this.msg});
}
