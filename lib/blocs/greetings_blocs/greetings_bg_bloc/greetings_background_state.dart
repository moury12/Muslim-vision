part of 'greetings_background_bloc.dart';

@immutable
abstract class GreetingsBackgroundState {}

 class GreetingsBackgroundInitial extends GreetingsBackgroundState {}
 // ignore: must_be_immutable
 class GreetingsBackgroundLoadedState extends GreetingsBackgroundState {
  List greetingBackgrounds;
  GreetingsBackgroundLoadedState({required this.greetingBackgrounds});
 }
 class GreetingsBackgroundErrorState extends GreetingsBackgroundState {}
