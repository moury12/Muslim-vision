// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';

import '../../controllers/services/common_strings.dart';
import '../../models/salat_procedure_model.dart';

part 'salat_procedure_event.dart';

part 'salat_procedure_state.dart';

class SalatProcedureBloc extends Bloc<SalatProcedureEvent, SalatProcedureState> {
  SalatProcedureBloc() : super(SalatProcedureInitialState()) {
    /*--------------------------------------- Variables ----------------------------------------*/
    SalatProcedureModel? salatProcedureData;
    Map arguments = {};
    int counter = 0;
    int rakatNumber = 1;
    /*--------------------------------------- Functions ----------------------------------------*/
    on<SalatProcedureLoadedEvent>((event, emit) async {
      emit(SalatProcedureInitialState());
      //get
      salatProcedureData = HiveFunctions().getSalatProcedureModelFromHive();

      // ------- InitialImages ---------------
      final initialImages = [salatStanding, takbeer, salatTieHand, salatTieHand];
      for (int i = 0; i < salatProcedureData!.initial.length; i++) {
        salatProcedureData!.initial[i].imageUrl = initialImages[i];
      }
      // ------- CommonImages ---------------
      final commonImages = [salatTieHand, salatTieHand, ruku, qiyam, sijda, sitFirst, sijda];
      for (int i = 0; i < salatProcedureData!.common.length; i++) {
        salatProcedureData!.common[i].imageUrl = commonImages[i];
      }
      salatProcedureData!.standing.imageUrl = salatTieHand;
      salatProcedureData!.sitting1.imageUrl = sitFirst;
      salatProcedureData!.sitting2.imageUrl = sitSecond;
      salatProcedureData!.salam.imageUrl = salamAll;
      salatProcedureData!.witr.imageUrl = salatTieHand;
      arguments = event.salatArguments;
      emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber));
    });

    on<SalatProcedureIncrementCountEvent>((event, emit) {
      counter++;
      log(salatProcedureData!.initial.length.toString(),name: "*************************");
      /*-------------------- Two Rakat Salat --------------------*/
      if (arguments['rakatNumber'] == '2') {
        if (counter < salatProcedureData!.initial.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1,));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 2));
        } else if (counter == 20) {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 2));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter = 20, rakatNumber = 2));
        }
      }

      /*-------------------- Three Rakat Salat --------------------*/

      else if (arguments['rakatNumber'] == '3' && arguments['waktName'] != 'Isha’a') {
        if (counter < salatProcedureData!.initial.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting1, counter, rakatNumber = 2));
        } else if (counter == 20) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 3));
        } else if (counter > 20 && counter < 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 21], counter, rakatNumber = 3));
        } else if (counter == 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 3));
        } else if (counter == 29) {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 3));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter = 29, rakatNumber = 3));
        }
      }
      //Witir
      else if (arguments['rakatNumber'] == '3' && arguments['waktName'] == 'Isha’a') {
        if (counter < salatProcedureData!.initial.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.witr, counter, rakatNumber = 2));
        } else if (counter > 19 && counter < 27) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 20], counter, rakatNumber = 3));
        } else if (counter == 27) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 3));
        } else if (counter == 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 3));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter = 28, rakatNumber = 3));
        }
      }
      /*-------------------- Four Rakat Salat --------------------*/
      else if (arguments['rakatNumber'] == '4') {
        if (counter < salatProcedureData!.initial.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting1, counter, rakatNumber = 2));
        } else if (counter == 20) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 3));
        } else if (counter > 20 && counter < 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 21], counter, rakatNumber = 3));
        } else if (counter == 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 4));
        } else if (counter > 28 && counter < 36) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 29], counter, rakatNumber = 4));
        } else if (counter == 36) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 4));
        } else if (counter == 37) {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 4));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter = 37, rakatNumber = 4));
        }
      }
    });

    on<SalatProcedureDecrementCountEvent>((event, emit) {
      if (counter < 1) {
        return;
      }
      counter--;
/*-------------------- Two Rakat Salat --------------------*/
      if (arguments['rakatNumber'] == '2') {
        if (salatProcedureData!.initial.length > counter) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 2));
        } else if (counter == 20) {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 2));
        } else {
          return;
        }
      }

      /*-------------------- Three Rakat Salat --------------------*/
      else if (arguments['rakatNumber'] == '3' && arguments['waktName'] != 'Isha’a') {
        if (salatProcedureData!.initial.length > counter) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting1, counter, rakatNumber = 2));
        } else if (counter == 20) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 3));
        } else if (counter > 20 && counter < 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 21], counter, rakatNumber = 3));
        } else if (counter == 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 3));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 3));
        }
      }
      //Witir
      else if (arguments['rakatNumber'] == '3' && arguments['waktName'] == 'Isha’a') {
        if (salatProcedureData!.initial.length > counter) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.witr, counter, rakatNumber = 2));
        } else if (counter > 19 && counter < 27) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 20], counter, rakatNumber = 3));
        } else if (counter == 27) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 3));
        } else if (counter == 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 3));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter = 28, rakatNumber = 3));
        }
      }

      /*-------------------- Four Rakat Salat --------------------*/
      else if (arguments['rakatNumber'] == '4') {
        if (salatProcedureData!.initial.length > counter) {
          emit(SalatProcedureLoadedState(salatProcedureData!.initial[counter], counter, rakatNumber = 1));
        } else if (counter >= salatProcedureData!.initial.length &&
            counter < salatProcedureData!.initial.length + salatProcedureData!.common.length) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - salatProcedureData!.initial.length], counter, rakatNumber = 1));
        } else if (counter == 11) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 2));
        } else if (counter > 11 && counter < 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 12], counter, rakatNumber = 2));
        } else if (counter == 19) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting1, counter, rakatNumber = 2));
        } else if (counter == 20) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 3));
        } else if (counter > 20 && counter < 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 21], counter, rakatNumber = 3));
        } else if (counter == 28) {
          emit(SalatProcedureLoadedState(salatProcedureData!.standing, counter, rakatNumber = 4));
        } else if (counter > 28 && counter < 36) {
          emit(SalatProcedureLoadedState(salatProcedureData!.common[counter - 29], counter, rakatNumber = 4));
        } else if (counter == 36) {
          emit(SalatProcedureLoadedState(salatProcedureData!.sitting2, counter, rakatNumber = 4));
        } else {
          emit(SalatProcedureLoadedState(salatProcedureData!.salam, counter, rakatNumber = 4));
        }
      }
    });
  }
}
