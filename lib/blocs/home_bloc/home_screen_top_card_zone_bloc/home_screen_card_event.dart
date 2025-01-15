part of 'home_screen_card_bloc.dart';

@immutable
abstract class HomeScreenCardEvent {}

class HomeScreenCardLoadedEvent extends HomeScreenCardEvent {}
class HomeScreenCardWaktLeftTimerEvent extends HomeScreenCardEvent {
  final Map<String, dynamic> waqtTimedetails;


  HomeScreenCardWaktLeftTimerEvent( { required this.waqtTimedetails});
}
