part of 'eid_procedure_bloc.dart';

@immutable
abstract class EidProcedureEvent {}

class EidProcedureLoadedEvent extends EidProcedureEvent {}

class EidProcedureIncrementEvent extends EidProcedureEvent {}

class EidProcedureDecrementEvent extends EidProcedureEvent {}
