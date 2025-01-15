part of 'quran_search_bloc.dart';

@immutable
class QuranSearchState {}

class QuranSearchInitial extends QuranSearchState {

}

class QuranSearchLoadedState extends QuranSearchState {
  final List<dynamic> quranList;
  final List<dynamic> filterQuranList;
  final bool isSearch;
  QuranSearchLoadedState(this.isSearch, {required this.quranList,required this.filterQuranList});
}
class QuranSearchToggleState extends QuranSearchState{
  final bool isSearch;

  QuranSearchToggleState({ this.isSearch = true});

}
