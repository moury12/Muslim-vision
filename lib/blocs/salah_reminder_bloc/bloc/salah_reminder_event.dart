part of 'salah_reminder_bloc.dart';

@immutable
abstract class SalahReminderEvent {}

class SalahReminderLoadedEvent extends SalahReminderEvent {}

class SalahReminderEditEvent extends SalahReminderEvent {
  final Map<int, SalahReminderModel> salahReminderMap;
  SalahReminderEditEvent({required this.salahReminderMap});
}

class SalahReminderSaveEvent extends SalahReminderEvent {
  final BuildContext context;
  SalahReminderSaveEvent({required this.context});
}
