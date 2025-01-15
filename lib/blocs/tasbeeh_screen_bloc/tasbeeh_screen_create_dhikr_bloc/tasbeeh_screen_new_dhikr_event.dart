part of 'tasbeeh_screen_new_dhikr_bloc.dart';

@immutable
abstract class TasbeehScreenNewDhikrEvent {}

class TasbeehScreenNewDhikrSaveEvent extends TasbeehScreenNewDhikrEvent {
  final Map<String, dynamic> newDhikrFields;

  TasbeehScreenNewDhikrSaveEvent(this.newDhikrFields);
}

class TasbeehScreenNewDhikrCounterIncreaseEvent extends TasbeehScreenNewDhikrEvent {}

class TasbeehScreenNewDhikrCounterDecreaseEvent extends TasbeehScreenNewDhikrEvent {}

class TasbeehScreenNewDhikrNumberCountEvent extends TasbeehScreenNewDhikrEvent {
  final int countNumber;
  final int index;
  TasbeehScreenNewDhikrNumberCountEvent(this.countNumber, this.index);
}
