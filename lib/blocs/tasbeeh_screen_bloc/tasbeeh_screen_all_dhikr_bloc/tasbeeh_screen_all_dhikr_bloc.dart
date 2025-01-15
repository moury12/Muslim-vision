

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import '../../../database/boxes.dart';

part 'tasbeeh_screen_all_dhikr_event.dart';
part 'tasbeeh_screen_all_dhikr_state.dart';

class TasbeehScreenAllDhikrBloc extends Bloc<TasbeehScreenAllDhikrEvent, TasbeehScreenAllDhikrState> {
  TasbeehScreenAllDhikrBloc() : super(TasbeehScreenAllDhikrInitialState()) {
    final Box dhikrBox = Boxes().tasbeehBox;
    /*This Function is used for Add And Delete Data from List*/
    List getDhikrData() {
      final allDhikrData = [];
      for (int i = 0; i < dhikrBox.keys.toList().length; i++) {
        if (dhikrBox.keys.toList()[i] != 'TasbeehInitialData') {
          allDhikrData.add(Map.from(dhikrBox.values.toList()[i]));
        }
      }
      return allDhikrData;
    }

    on<TasbeehScreenAllDhikrLoadedEvent>((event, emit) {
      emit(TasbeehScreenAllDhikrLoadedState(getDhikrData()));
    });
    on<TasbeehScreenAllDhikrSearchEvent>((event, emit) {
      List getSearchedData = getDhikrData().where((element) => element['name'].toLowerCase().contains(event.searchValue.toLowerCase())).toList();
      emit(TasbeehScreenAllDhikrLoadedState(getSearchedData));
    });
    on<TasbeehScreenAllDhikrDeleteEvent>((event, emit) async {
      if (event.dhikrName == 'SubhanAllah' || event.dhikrName == 'Alhamdulillah' || event.dhikrName == 'Allahu Akbar') {
        /* A pop up toast will appear */

        return;
      }
      if (dhikrBox.get('TasbeehInitialData').values.isNotEmpty) {
        if (event.dhikrName == dhikrBox.get('TasbeehInitialData')['singleDhikrData']['name']) {
          await dhikrBox.put('TasbeehInitialData', {});
        }
      }

      await dhikrBox.delete(event.dhikrName);

      emit(TasbeehScreenAllDhikrLoadedState(getDhikrData()));
    });
  }
}
