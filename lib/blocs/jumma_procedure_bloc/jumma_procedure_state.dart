part of 'jumma_procedure_bloc.dart';

@immutable
abstract class JummaProcedureState {}

class JummaProcedureInitialState extends JummaProcedureState {}

class JummaProcedureLoadedState extends JummaProcedureState {
  final int counter;
  final List<JummaProcedureModel> jummaData;

  JummaProcedureLoadedState(this.counter, this.jummaData);
}
