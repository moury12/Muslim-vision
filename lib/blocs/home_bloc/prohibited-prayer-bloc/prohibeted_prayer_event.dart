part of 'prohibeted_prayer_bloc.dart';

@immutable
abstract class ProhibetedPrayerEvent{}
 class ProhibetedPrayerLoadedEvent extends ProhibetedPrayerEvent{
  final bool? isSunrise;
  final bool? isSunset;
  final bool? isZenith;

  ProhibetedPrayerLoadedEvent({ this.isSunrise=false,  this.isSunset=false,  this.isZenith=false});
}

