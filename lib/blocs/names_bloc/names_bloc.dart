

// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muslim_vision/controllers/repositories.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/models/name_model.dart';
part 'names_event.dart';
part 'names_state.dart';

class NamesBloc extends Bloc<NamesEvent, NamesState> {
  List<NameList> girlsName = [];
  List<NameList> boysName = [];

  NamesBloc() : super(NamesInitial()) {
    on<InitialNameLoadedEvent>((event, emit) async {
      if (Boxes().namesDataBox.get('boysName') != null) {
        List<NameModel> names =
            nameModelFromJson(Boxes().namesDataBox.get('boysName'));
        for (var element in names) {
          boysName.addAll(element.nameList!.toList());
        }
        if (kDebugMode) {
        //  print('boysName Length:${boysName.length}');
        }
      } else {
        List<NameModel> names = await Repositories().getBoysName();
        if (kDebugMode) {
         // print(
             // '=======================BoysName API HIT=======================');
        }
        await Boxes().namesDataBox.put('boysName', nameModelToJson(names));
        for (var element in names) {
          boysName.addAll(element.nameList!.toList());
        }
        if (kDebugMode) {
          print('boysName Length:${boysName.length}');
        }
      }
      if (Boxes().namesDataBox.get('girlsName') != null) {
        List<NameModel> names =
            nameModelFromJson(Boxes().namesDataBox.get('girlsName'));
        for (var element in names) {
          girlsName.addAll(element.nameList!.toList());
        }
        if (kDebugMode) {
          print('girlsName Length:${girlsName.length}');
        }
      } else {
        List<NameModel> names = await Repositories().getGirlsName();
        if (kDebugMode) {
          print(
              '=======================GirlsName API HIT=======================');
        }
        await Boxes().namesDataBox.put('girlsName', nameModelToJson(names));
        for (var element in names) {
          girlsName.addAll(element.nameList!.toList());
        }
        if (kDebugMode) {
          print('girlsName Length:${girlsName.length}');
        }
      }
      emit(InitialNameLoadedState(boysName: boysName, girlsName: girlsName));
    });
    on<SearchEvent>(
      (event, emit) {
        List<NameList> searchboysName = boysName
            .where((element) =>
                element.nameInBangla!
                    .toLowerCase()
                    .toString()
                    .contains(event.searchTerm.toLowerCase().toString()) ||
                element.nameInEnglish!
                    .toLowerCase()
                    .toString()
                    .contains(event.searchTerm.toLowerCase().toString()) ||
                element.nameInArabic!
                    .toLowerCase()
                    .toString()
                    .contains(event.searchTerm.toLowerCase().toString()))
            .toList();

        List<NameList> searchgirlsName = girlsName
            .where((element) =>
                element.nameInBangla!
                    .toLowerCase()
                    .toString()
                    .contains(event.searchTerm.toLowerCase().toString()) ||
                element.nameInEnglish!
                    .toLowerCase()
                    .toString()
                    .contains(event.searchTerm.toLowerCase().toString()) ||
                element.nameInArabic!
                    .toLowerCase()
                    .toString()
                    .contains(event.searchTerm.toLowerCase().toString()))
            .toList();

        emit(InitialNameLoadedState(
            girlsName: searchgirlsName, boysName: searchboysName));
      },
    );
  }
}
