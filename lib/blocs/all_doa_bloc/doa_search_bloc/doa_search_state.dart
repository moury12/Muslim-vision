// ignore_for_file: must_be_immutable

part of 'doa_search_bloc.dart';

@immutable
abstract class DoaSearchState {}

class DoaSearchInitial extends DoaSearchState {}

class DoaSecrchClickState extends DoaSearchState {
  bool isSearch;
  List<SubCategory> searchValue;
  DoaSecrchClickState(this.isSearch, this.searchValue);
}

class DoaScreenSearchStartState extends DoaSearchState {
  List<SubCategory> searchValue;
  DoaScreenSearchStartState(this.searchValue);
}
