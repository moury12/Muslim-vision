part of 'jumma_procedure_bloc.dart';

@immutable
abstract class JummaProcedureEvent {}

class JummaProcedureLoadedEvent extends JummaProcedureEvent {}

class JummaProcedureIncrementEvent extends JummaProcedureEvent {}

class JummaProcedureDecrementEvent extends JummaProcedureEvent {}
