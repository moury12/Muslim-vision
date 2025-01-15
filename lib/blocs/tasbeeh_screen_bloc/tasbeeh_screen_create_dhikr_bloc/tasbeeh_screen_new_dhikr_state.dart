part of 'tasbeeh_screen_new_dhikr_bloc.dart';

@immutable
abstract class TasbeehScreenNewDhikrState {}

class TasbeehScreenNewDhikrInitialState extends TasbeehScreenNewDhikrState {}

class TasbeehScreenNewDhikrSaveState extends TasbeehScreenNewDhikrState {}

class TasbeehScreenNewDhikrCounterState extends TasbeehScreenNewDhikrState {
  final List<int> numbers;
  final int counter;
  final int index;
  TasbeehScreenNewDhikrCounterState(this.counter, this.numbers, this.index);
}
