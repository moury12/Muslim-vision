

part of 'greetingsbloc_bloc.dart';

abstract class GreetingsblocState {}

 class GreetingsblocInitial extends GreetingsblocState {}

 class GreetingsLodedState extends GreetingsblocState {
  List<GreetingsModel> greetings;
  bool isInternet;
  GreetingsLodedState({required this.greetings,required this.isInternet});

 }
