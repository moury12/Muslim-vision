part of 'home_screen_card_bloc.dart';

@immutable
abstract class HomeScreenCardState {}

 class HomeScreenCardInitialState extends HomeScreenCardState {}

class HomeScreenCardNoLocationState extends HomeScreenCardState {}

class HomeScreenCardLoadedState extends HomeScreenCardState {
  final Map<String, dynamic> getWaktDetails;
  HomeScreenCardLoadedState(this.getWaktDetails);
}


