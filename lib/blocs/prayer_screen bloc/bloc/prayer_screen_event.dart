part of 'prayer_screen_bloc.dart';

@immutable
abstract class PrayerScreenEvent {}

class PrayerCityLoadingEvent extends PrayerScreenEvent {}

class PrayerCityCalendarToggleEvent extends PrayerScreenEvent {}

class PrayerCalendarButtonLoadingEvent extends PrayerScreenEvent {}

//button and date click
class PrayerButtonEvent extends PrayerScreenEvent {
  final String key;
  PrayerButtonEvent(this.key);
}

class PrayerDateClickEvent extends PrayerScreenEvent {
  final DateTime selectDateEvent;
  PrayerDateClickEvent(this.selectDateEvent);
}

class DisableTrackClickEvent extends PrayerScreenEvent {}
