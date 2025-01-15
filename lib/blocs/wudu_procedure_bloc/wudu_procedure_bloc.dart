// ignore_for_file: depend_on_referenced_packages

import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../controllers/services/common_strings.dart';
import '../../controllers/services/hive_functions.dart';
import '../../models/wudu_procedure_model.dart';

part 'wudu_procedure_event.dart';

part 'wudu_procedure_state.dart';

class WuduProcedureBloc extends Bloc<WuduProcedureEvent, WuduProcedureState> {
  WuduProcedureBloc() : super(WuduProcedureInitialState()) {
    /*--------------------------------------- Variables ----------------------------------------*/
    List<WuduProcedureModel> wuduProcedureData = HiveFunctions().getWuduProcedureDataFromHive();
    int counter = 0;
    /*--------------------------------------- Functions ----------------------------------------*/
    on<WuduProcedureLoadedEvent>((event, emit) {
      counter = event.counter;
      emit(WuduProcedureInitialState());
      // ------- Image Initialization ---------------
      final initializeImages = [bismillah, bismillah, handWash, kuli, noseWash, faceWash, fullHandWash, headMaseh, legWash, ''];
      for (int i = 0; i < wuduProcedureData.first.data.length; i++) {
        wuduProcedureData.first.data[i].imageUrl = initializeImages[i];
      }
      emit(WuduProcedureLoadedState(counter, wuduProcedureData.first.data[counter],false));
    });
    on<WuduProcedureIncrementEvent>((event, emit) {
      if (counter == wuduProcedureData.first.data.length - 1) {
        emit(WuduProcedureLoadedState(counter, wuduProcedureData.first.data[counter],true));
        return;
      }
      counter++;
      emit(WuduProcedureLoadedState(counter, wuduProcedureData.first.data[counter],false));
    });
    on<WuduProcedureDecrementEvent>((event, emit) {
      if (counter < 1) {
        return;
      }
      counter--;
      emit(WuduProcedureLoadedState(counter, wuduProcedureData.first.data[counter],false));
    });
  }
}
