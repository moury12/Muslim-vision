
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';
import 'package:muslim_vision/models/jumma_procedure_model.dart';

part 'jumma_procedure_event.dart';

part 'jumma_procedure_state.dart';

class JummaProcedureBloc extends Bloc<JummaProcedureEvent, JummaProcedureState> {
  JummaProcedureBloc() : super(JummaProcedureInitialState()) {
    late List<JummaProcedureModel> jummaProcedureData;
    int counter = 0;
    on<JummaProcedureLoadedEvent>((event, emit) {
      emit(JummaProcedureInitialState());
      jummaProcedureData = HiveFunctions().getJummaProcedureDataFromHive();
      emit(JummaProcedureLoadedState(counter, jummaProcedureData));
    });
    on<JummaProcedureIncrementEvent>((event, emit) {
      if (counter == jummaProcedureData.length - 1) {
        return;
      }
      counter++;
      emit(JummaProcedureLoadedState(counter, jummaProcedureData));
    });
    on<JummaProcedureDecrementEvent>((event, emit) {
      if (counter < 1) {
        return;
      }
      counter--;
      emit(JummaProcedureLoadedState(counter, jummaProcedureData));
    });
  }
}
