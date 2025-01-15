part of 'salat_procedure_bloc.dart';

@immutable
abstract class SalatProcedureState {}

abstract class SalatProcedureActionState extends SalatProcedureState {}

class SalatProcedureInitialState extends SalatProcedureState {}

class SalatProcedureLoadedState extends SalatProcedureState {
  final Salam salatProcedureInitialData;
  final int counter;
  final int rakatNumber;
  SalatProcedureLoadedState(this.salatProcedureInitialData, this.counter, this.rakatNumber);
}

class SalatProcedureErrorState extends SalatProcedureState {}
