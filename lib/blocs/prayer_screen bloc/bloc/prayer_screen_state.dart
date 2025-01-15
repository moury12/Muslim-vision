part of 'prayer_screen_bloc.dart';

@immutable
abstract class PrayerScreenState {}

class PrayerScreenInitial extends PrayerScreenState {}

class PrayerLoadingState extends PrayerScreenState {}

class PrayerCityLoadedState extends PrayerScreenState {
  final String city;
  PrayerCityLoadedState(this.city);
}

class PrayerCalendarState extends PrayerScreenState {
  final Map<dynamic, Map<dynamic, dynamic>> salatTrack;
  final DateTime selectDate;
  PrayerCalendarState(this.salatTrack, this.selectDate);
}

class PrayerButtonsState extends PrayerScreenState {
  final List<bool> rakat;
  final DateTime selectDate;
  PrayerButtonsState(this.rakat, this.selectDate);
}

class DisableButtonsState extends PrayerScreenState {}
