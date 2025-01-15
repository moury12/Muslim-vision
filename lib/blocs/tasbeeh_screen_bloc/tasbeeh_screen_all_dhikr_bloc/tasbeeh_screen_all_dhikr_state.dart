part of 'tasbeeh_screen_all_dhikr_bloc.dart';

@immutable
abstract class TasbeehScreenAllDhikrState {}

class TasbeehScreenAllDhikrInitialState extends TasbeehScreenAllDhikrState {}

class TasbeehScreenAllDhikrLoadedState extends TasbeehScreenAllDhikrState {
  final List allDhikr;

  TasbeehScreenAllDhikrLoadedState(this.allDhikr);
}
