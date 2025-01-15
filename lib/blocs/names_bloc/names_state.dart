part of 'names_bloc.dart';

@immutable
abstract class NamesState {}

 class NamesInitial extends NamesState {}

class InitialNameLoadedState extends NamesState {
  final List<NameList> girlsName;
  final List<NameList> boysName;
  InitialNameLoadedState({
    required this.girlsName,
    required this.boysName,
  });
}

class NameLoadingState extends NamesState {}