
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../../../database/boxes.dart';

part 'tasbeeh_screen_new_dhikr_event.dart';
part 'tasbeeh_screen_new_dhikr_state.dart';

class TasbeehScreenNewDhikrBloc extends Bloc<TasbeehScreenNewDhikrEvent, TasbeehScreenNewDhikrState> {
  TasbeehScreenNewDhikrBloc() : super(TasbeehScreenNewDhikrInitialState()) {
    int counter = 0;
    List<int> numbers = [33, 65, 99, 149, 299, 499, 999];
    on<TasbeehScreenNewDhikrCounterIncreaseEvent>((event, emit) {
      counter++;
      emit(TasbeehScreenNewDhikrCounterState(counter, numbers, -1));
    });
    on<TasbeehScreenNewDhikrCounterDecreaseEvent>((event, emit) {
      if (counter < 1) {
        return;
      }
      counter--;
      emit(TasbeehScreenNewDhikrCounterState(counter, numbers, -1));
    });
    on<TasbeehScreenNewDhikrNumberCountEvent>((event, emit) {
      counter = event.countNumber;

      emit(TasbeehScreenNewDhikrCounterState(counter, numbers, event.index));
    });
    on<TasbeehScreenNewDhikrSaveEvent>((event, emit) async {
      if (counter == 0) {
        return;
        /* Pop up will appear here */
      }
      event.newDhikrFields['count'] = counter;
      final Box dhikrBox = Boxes().tasbeehBox;
      await dhikrBox.put(event.newDhikrFields['name'], event.newDhikrFields);
    });
  }
}
