// ignore_for_file: must_be_immutable

part of 'doa_search_bloc.dart';

@immutable
abstract class DoaSearchEvent {}

class IsSearchEvent extends DoaSearchEvent {
  bool isSearch;
  String searchItem;
  IsSearchEvent(this.isSearch, this.searchItem);
}

class DoasSrarchStartEvent extends DoaSearchEvent {
  String searchItem;
  DoasSrarchStartEvent(this.searchItem);
}
