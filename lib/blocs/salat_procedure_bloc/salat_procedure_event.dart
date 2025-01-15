part of 'salat_procedure_bloc.dart';

@immutable
abstract class SalatProcedureEvent {}

class SalatProcedureLoadingEvent extends SalatProcedureEvent {}

class SalatProcedureLoadedEvent extends SalatProcedureEvent {
  final Map salatArguments;

  SalatProcedureLoadedEvent(this.salatArguments);
}

class SalatProcedureIncrementCountEvent extends SalatProcedureEvent {
  // final Map salatArguments;
  //
  // SalatProcedureIncrementCountEvent(this.salatArguments);
}

class SalatProcedureDecrementCountEvent extends SalatProcedureEvent {}
