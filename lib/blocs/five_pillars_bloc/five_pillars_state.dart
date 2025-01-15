part of 'five_pillars_bloc.dart';

@immutable
abstract class FivePillarsState {}

class FivePillarsInitialState extends FivePillarsState {}

class FivePillarsLoadedState extends FivePillarsState {
  final List<FivePillarsOfIslamModel> fivePillarsData;
  FivePillarsLoadedState({ required this.fivePillarsData});
}