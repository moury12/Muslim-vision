// ignore_for_file: must_be_immutable

part of 'qurbani_bloc.dart';

@immutable
abstract class QurbaniState {}

 class QurbaniInitial extends QurbaniState {}

 class QurbaniLoadedState extends QurbaniState {
  List<QurbaniModel> qurbaniData;
  QurbaniLoadedState({required this.qurbaniData});
 }
