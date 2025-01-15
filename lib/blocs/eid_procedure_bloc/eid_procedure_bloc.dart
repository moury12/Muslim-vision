// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../controllers/services/common_strings.dart';
import '../../controllers/services/hive_functions.dart';
import '../../models/eid_procedure_model.dart';

part 'eid_procedure_event.dart';

part 'eid_procedure_state.dart';

class EidProcedureBloc extends Bloc<EidProcedureEvent, EidProcedureState> {
  EidProcedureBloc() : super(EidProcedureInitialState()) {
    List<EidProcedureModel> eidProcedureData = HiveFunctions().getEidProcedureDataFromHive();
    int counter = 0;
    on<EidProcedureLoadedEvent>((event, emit) {
      for (int i = 0; i < eidProcedureData.length; i++) {
        if (i == 6) {
          eidProcedureData[i].data.first.imageUrl = salatStanding;
        }
        if (i >= 7 && i <= 9) {
          eidProcedureData[i].data.first.imageUrl = takbeer;
        }
      }
      emit(EidProcedureInitialState());
      emit(EidProcedureLoadedState(counter, eidProcedureData[counter],false));
    });
    on<EidProcedureIncrementEvent>((event, emit) {
      if (counter == eidProcedureData.length - 1) {
        emit(EidProcedureLoadedState(counter, eidProcedureData[counter],true));
        return;
      }
      counter++;
      emit(EidProcedureLoadedState(counter, eidProcedureData[counter],false));
    });
    on<EidProcedureDecrementEvent>((event, emit) {
      if (counter < 1) {
        return;
      }
      counter--;
      emit(EidProcedureLoadedState(counter, eidProcedureData[counter],false));
    });
  }
}
