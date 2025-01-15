// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';
import 'package:muslim_vision/models/doa_model.dart';

part 'doa_screen_event.dart';
part 'doa_screen_state.dart';

class DoaScreenBloc extends Bloc<DoaScreenEvent, DoaScreenState> {
  DoaScreenBloc() : super(DoaScreenInitial()) {
    on<DoaScreenLoadedEvent>((event, emit) {
      emit(DoaScreenLodingState());

      List<DoaModel> doaData = HiveFunctions().getDoasDatafromHive();
      emit(DoaScreenLodedState(doaList: doaData));
    });

    on<DoaScreenLoadedRamadanEvent>((event, emit) {
      emit(DoaScreenLodingState());

      List<DoaModel> doaData = HiveFunctions().getDoasDatafromHive();
      List<SubCategory> ramadanData=[];
      for (var element in doaData) {
        //|| element.categoryInEnglish=="Ramadan"
        if(element.categoryInBangla=="সাওম [রোজা]"){

          ramadanData.addAll(element.subCategories);
        }
      }
      emit(DoaScreenLodedRamadanState(ramadan: ramadanData));
    });

  }
}
