part of 'janaja_procedure_bloc.dart';

@immutable
abstract class JanajaProcedureState {}

class JanajaProcedureInitialState extends JanajaProcedureState {}

class JanajaProcedureLoadedState extends JanajaProcedureState {
  final int counter;
  final Datum janajaData;
  final bool? isLastindex;

  JanajaProcedureLoadedState(this.counter, this.janajaData, this.isLastindex);
}
