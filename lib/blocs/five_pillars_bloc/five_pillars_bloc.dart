// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/repositories.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/models/five_pillars_of_islam_model.dart';

part 'five_pillars_event.dart';
part 'five_pillars_state.dart';

class FivePillarsBloc extends Bloc<FivePillarsEvent, FivePillarsState> {
  FivePillarsBloc() : super(FivePillarsInitialState()) {

    on<FivePillarsScreenLoadedEvent>((event, emit) async {
      emit(FivePillarsInitialState());
      List<FivePillarsOfIslamModel> fivePillarsList = [];

      if (Boxes().fivePillarsDataBox.isNotEmpty) {
        fivePillarsList = HiveFunctions().getFivePillarsOfIslamDatafromHive();
      } else {
        fivePillarsList = await Repositories().getFivePillarsOfIslamData();
        await Boxes().fivePillarsDataBox.put("fivePillarsDataBox", fivePillarsOfIslamModelToJson(fivePillarsList));
      }

      List images = [shahada,salah,zakat,hajj,sawm];
      for(int i=0; i<fivePillarsList.length; i++){
       fivePillarsList[i].data[0].imageUrl = images[i];
     }
      emit(FivePillarsLoadedState(fivePillarsData: fivePillarsList));

    });
  }
}
