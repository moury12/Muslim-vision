// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';
import 'package:muslim_vision/models/greetings_model.dart';

part 'greetingsbloc_event.dart';
part 'greetingsbloc_state.dart';

class GreetingsblocBloc extends Bloc<GreetingsblocEvent, GreetingsblocState> {
  GreetingsblocBloc() : super(GreetingsblocInitial()) {
    // on<GreetingsblocEvent>((event, emit) {

    // });
    on<GreetingLodedEvent>((event, emit) async {
      if (await CommonFunctions().hasInternetConnection()) {
        List<GreetingsModel> greetingData = HiveFunctions().getGreetingsDatafromHive();

        emit(GreetingsLodedState(greetings: greetingData, isInternet: true));
      } else {
        emit(GreetingsblocInitial());
      }
    });
  }
}
