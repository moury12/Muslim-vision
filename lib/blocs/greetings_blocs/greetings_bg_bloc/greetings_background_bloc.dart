// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/repositories.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';


part 'greetings_background_event.dart';
part 'greetings_background_state.dart';

class GreetingsBackgroundBloc extends Bloc<GreetingsBackgroundEvent, GreetingsBackgroundState> {
  GreetingsBackgroundBloc() : super(GreetingsBackgroundInitial()) {
    on<GreetingsBackgroundEvent>((event, emit) async{
     emit(GreetingsBackgroundInitial());
     if(await CommonFunctions().hasInternetConnection()){
 

      List data=await Repositories().getGreetingsBackgroundData();
     emit(GreetingsBackgroundLoadedState(greetingBackgrounds:data ));
      
     }else{
      emit(GreetingsBackgroundErrorState());
     }
    });
  }
}
