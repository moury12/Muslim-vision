part of 'wudu_procedure_bloc.dart';

@immutable
abstract class WuduProcedureState {}

class WuduProcedureInitialState extends WuduProcedureState {}

class WuduProcedureLoadedState extends WuduProcedureState {
  final int counter;
  final Datum wuduData;
  final bool? isLastindex;


  WuduProcedureLoadedState(this.counter, this.wuduData, this.isLastindex);
}
