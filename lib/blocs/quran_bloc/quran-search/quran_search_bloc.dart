// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'quran_search_event.dart';
part 'quran_search_state.dart';

class QuranSearchBloc extends Bloc<QuranSearchEvent, QuranSearchState> {
  QuranSearchBloc() : super(QuranSearchInitial()) {
    on<QuranSearchLoadedEvent>((event, emit) async {
      emit(QuranSearchInitial());
      List<dynamic> surahInfo = jsonDecode(await rootBundle.loadString('assets/json/QuranJson/quran-surah-names.json'));

      emit(QuranSearchLoadedState(event.value != null && event.value!.isNotEmpty ? false : true, quranList: surahInfo, filterQuranList: surahInfo));
      if (event.value != null && event.value!.isNotEmpty) {
        List<dynamic> filteredList = surahInfo.where((element) => element['name_in_bangla'].toString().toUpperCase().contains(event.value!) || element['name_in_bangla'].toString().toLowerCase().contains(event.value!)).toList();
        emit(QuranSearchLoadedState(
          event.value != null && event.value!.isNotEmpty ? false : true,
          quranList: surahInfo,
          filterQuranList: filteredList,
        ));
      }
    });
  }
}
