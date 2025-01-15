part of 'tasbeeh_screen_all_dhikr_bloc.dart';

@immutable
abstract class TasbeehScreenAllDhikrEvent {}

class TasbeehScreenAllDhikrLoadedEvent extends TasbeehScreenAllDhikrEvent {}

class TasbeehScreenAllDhikrSearchEvent extends TasbeehScreenAllDhikrEvent {
  final String searchValue;

  TasbeehScreenAllDhikrSearchEvent(this.searchValue);
}

class TasbeehScreenAllDhikrDeleteEvent extends TasbeehScreenAllDhikrEvent {
  final String dhikrName;

  TasbeehScreenAllDhikrDeleteEvent(this.dhikrName);
}
