// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/repositories.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/models/qurbani_model.dart';

part 'qurbani_event.dart';
part 'qurbani_state.dart';

class QurbaniBloc extends Bloc<QurbaniEvent, QurbaniState> {
  QurbaniBloc() : super(QurbaniInitial()) {

    on<QurbaniScreenLodedScerrnEvent>((event, emit) async {
      emit(QurbaniInitial());
      List<QurbaniModel> qurbaniList = [];

      if (Boxes().qurbaniDataBox.isNotEmpty) {
        qurbaniList = HiveFunctions().getQurbaniDatafromHive();
      } else {
        qurbaniList = await Repositories().getQurbaniData();
        await Boxes().fivePillarsDataBox.put("qurbaniDataBox", qurbaniModelToJson(qurbaniList));
      }
      emit(QurbaniLoadedState(qurbaniData: qurbaniList));
    });

  }
}
