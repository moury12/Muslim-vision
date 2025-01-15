part of 'prohibeted_prayer_bloc.dart';

@immutable
abstract class ProhibetedPrayerState {}

class ProhibetedPrayerInitial extends ProhibetedPrayerState {}

class ProhibetedPrayerNoLocationState extends ProhibetedPrayerState {}

class ProhibetedPrayerLoadedState extends ProhibetedPrayerState {
  final List<Map<String, dynamic>> prohibitedPrayerList;

  final List<bool>? isProhibited;
  ProhibetedPrayerLoadedState({
    required this.prohibitedPrayerList,
   List<bool>? isProhibited,
  }): isProhibited = isProhibited ?? List.generate(3, (index) => false);
}
