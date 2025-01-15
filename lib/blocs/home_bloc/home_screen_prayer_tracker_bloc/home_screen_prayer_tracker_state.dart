part of 'home_screen_prayer_tracker_bloc.dart';

@immutable
abstract class HomeScreenPrayerTrackerState {}

class HomeScreenPrayerTrackerInitialState extends HomeScreenPrayerTrackerState {}
class HomeScreenPrayerTrackerNoLocationState extends HomeScreenPrayerTrackerState {}

class HomeScreenPrayerTrackerLoadedState extends HomeScreenPrayerTrackerState {
  final List<String> waktTimes;
 final List<bool> rakat;


  HomeScreenPrayerTrackerLoadedState({ required this.waktTimes,required this.rakat});
}
