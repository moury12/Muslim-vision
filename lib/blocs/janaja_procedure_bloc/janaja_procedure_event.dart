part of 'janaja_procedure_bloc.dart';

@immutable
abstract class JanajaProcedureEvent {}

class JanajaProcedureLoadedEvent extends JanajaProcedureEvent {}

class JanajaProcedureIncrementEvent extends JanajaProcedureEvent {}

class JanajaProcedureDecrementEvent extends JanajaProcedureEvent {}
