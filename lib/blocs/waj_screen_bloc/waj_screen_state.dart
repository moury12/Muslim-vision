// ignore_for_file: must_be_immutable

part of 'waj_screen_bloc.dart';

@immutable
abstract class WajScreenState {}

 class WajScreenInitial extends WajScreenState {
  
 }
 class WajLoadedState extends WajScreenState {
   List<Map<String, Object>> wajData;

   WajLoadedState(this.wajData);

 }
 class WajPlayState extends WajScreenState {
   final String url;

   WajPlayState(this.url);

 }
