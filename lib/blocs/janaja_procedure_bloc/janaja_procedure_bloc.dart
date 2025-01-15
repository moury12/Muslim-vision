
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/models/janaja_procedure_model.dart';

import '../../controllers/services/common_strings.dart';
import '../../controllers/services/hive_functions.dart';

part 'janaja_procedure_event.dart';

part 'janaja_procedure_state.dart';

class JanajaProcedureBloc extends Bloc<JanajaProcedureEvent, JanajaProcedureState> {
  /*--------------------------------------- Variables ----------------------------------------*/
  List<JanajaProcedureModel> janajaProcedureData = HiveFunctions().getJanajaProcedureDataFromHive();
  int counter = 0;

  /*--------------------------------------- Functions ----------------------------------------*/
  JanajaProcedureBloc() : super(JanajaProcedureInitialState()) {
    on<JanajaProcedureLoadedEvent>((event, emit) {
      emit(JanajaProcedureInitialState());
      // ------- Image Initialization ---------------
      final initializeImages = [salatStanding, takbeer, salatTieHand, takbeer, salatTieHand, takbeer, salatTieHand, takbeer, janaja_salam];
      for (int i = 0; i < janajaProcedureData.first.data.length; i++) {
        janajaProcedureData.first.data[i].imageUrl = initializeImages[i];
      }
      emit(JanajaProcedureLoadedState(counter, janajaProcedureData.first.data[counter],false));
    });
    on<JanajaProcedureIncrementEvent>((event, emit) {
      if (counter == janajaProcedureData.first.data.length - 1) {
        emit(JanajaProcedureLoadedState(counter, janajaProcedureData.first.data[counter],true));

        return;
      }
      counter++;
      emit(JanajaProcedureLoadedState(counter, janajaProcedureData.first.data[counter],false));
    });
    on<JanajaProcedureDecrementEvent>((event, emit) {
      if (counter < 1) {
        return;
      }
      counter--;
      emit(JanajaProcedureLoadedState(counter, janajaProcedureData.first.data[counter],false));
    });
  }
}
