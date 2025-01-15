part of 'names_bloc.dart';

@immutable
abstract class NamesEvent {}

class InitialNameLoadedEvent extends NamesEvent {}

// class FilterGenderEvent extends NamesEvent {
//   final String gender;
//   FilterGenderEvent({
//     required this.gender,
//   });
// }

class SearchEvent extends NamesEvent {
  final String searchTerm;

  SearchEvent({required this.searchTerm});
}
