part of 'wudu_procedure_bloc.dart';

@immutable
abstract class WuduProcedureEvent {}

class WuduProcedureLoadedEvent extends WuduProcedureEvent {
  final int counter;

  WuduProcedureLoadedEvent(this.counter);
}

class WuduProcedureIncrementEvent extends WuduProcedureEvent {}

class WuduProcedureDecrementEvent extends WuduProcedureEvent {}
