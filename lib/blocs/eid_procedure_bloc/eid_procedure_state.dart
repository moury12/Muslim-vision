part of 'eid_procedure_bloc.dart';

@immutable
abstract class EidProcedureState {}

class EidProcedureInitialState extends EidProcedureState {}

class EidProcedureLoadedState extends EidProcedureState {
  final int counter;
  final EidProcedureModel eidData;
  final bool? isLastindex;

  EidProcedureLoadedState(this.counter, this.eidData, this.isLastindex);
}
