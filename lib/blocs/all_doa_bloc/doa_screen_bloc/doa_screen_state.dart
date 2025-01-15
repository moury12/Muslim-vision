// ignore_for_file: must_be_immutable

part of 'doa_screen_bloc.dart';

@immutable
abstract class DoaScreenState {}

class DoaScreenInitial extends DoaScreenState {}

class DoaScreenLodingState extends DoaScreenState {}

class DoaScreenLodedState extends DoaScreenState {
  List<DoaModel> doaList = [];
  DoaScreenLodedState({required this.doaList});
}

class DoaScreenLodedRamadanState extends DoaScreenState {
  List<SubCategory> ramadan = [];
  DoaScreenLodedRamadanState({required this.ramadan});
}
