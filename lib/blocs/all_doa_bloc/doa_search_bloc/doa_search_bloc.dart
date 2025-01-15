// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/services/hive_functions.dart';
import 'package:muslim_vision/models/doa_model.dart';

part 'doa_search_event.dart';
part 'doa_search_state.dart';

class DoaSearchBloc extends Bloc<DoaSearchEvent, DoaSearchState> {
  DoaSearchBloc() : super(DoaSearchInitial()) {
    // on<DoaSearchEvent>((event, emit) {
  
    // });
    on<IsSearchEvent>((event, emit) {
      if (event.isSearch) {
        List<DoaModel> doaData = HiveFunctions().getDoasDatafromHive();
        List<SubCategory> allDoas = [];
        for (var element in doaData) {
          allDoas.addAll(element.subCategories);
        }
        List<SubCategory> searchDoas = allDoas
            .where((element) => element.subCategoryInBangla.toLowerCase().toString().contains(event.searchItem.toLowerCase().toString()) || element.subCategoryInEnglish.toString().toLowerCase().contains(event.searchItem.toLowerCase().toString()))
            .toList();
        emit(DoaSecrchClickState(event.isSearch, searchDoas));
      } else {
        emit(DoaSearchInitial());
      }
    });

    on<DoasSrarchStartEvent>((event, emit) {
      List<DoaModel> doaData = HiveFunctions().getDoasDatafromHive();
      List<SubCategory> allDoas = [];
      for (var element in doaData) {
        allDoas.addAll(element.subCategories);
      }
      List<SubCategory> searchDoas = allDoas
          .where((element) => element.subCategoryInBangla.toLowerCase().toString().contains(event.searchItem.toLowerCase().toString()) || element.subCategoryInEnglish.toString().toLowerCase().contains(event.searchItem.toLowerCase().toString()))
          .toList();
      emit(DoaScreenSearchStartState(searchDoas));
    });
  }
}
