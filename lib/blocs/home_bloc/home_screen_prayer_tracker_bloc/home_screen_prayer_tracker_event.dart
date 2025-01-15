part of 'home_screen_prayer_tracker_bloc.dart';

@immutable
abstract class HomeScreenPrayerTrackerEvent {}

class HomeScreenPrayerTrackerLoadedEvent extends HomeScreenPrayerTrackerEvent {


}
class PrayerButtonEvent extends HomeScreenPrayerTrackerEvent {
  final String key;
  PrayerButtonEvent(this.key);
}
