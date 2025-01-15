// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/views/pages/waj_screen/waj_widgets/services/api_service.dart';

part 'waj_screen_event.dart';
part 'waj_screen_state.dart';

class WajScreenBloc extends Bloc<WajScreenEvent, WajScreenState> {
  WajScreenBloc() : super(WajScreenInitial()) {
    on<WajLoadedEvent>((event, emit) async {
      emit(WajScreenInitial());

      await Future.delayed(const Duration(seconds: 2));

      emit(WajLoadedState(videoList));
    });


    on<WajPlayEvent>((event, emit) {
     
      emit(WajPlayState(event.videoUrl));
      

    });
  }
}
