part of 'home_screen_names_of_allah_bloc.dart';

@immutable
abstract class HomeScreenNamesOfAllahEvent {}

class HomeScreenNamesOfAllahLoadedEvent extends HomeScreenNamesOfAllahEvent {
  final CardSwiperController controller;

  HomeScreenNamesOfAllahLoadedEvent(this.controller);
}

class HomeScreenNamesOfAllahSwipeEvent extends HomeScreenNamesOfAllahEvent {
  final int currentIndex;

  HomeScreenNamesOfAllahSwipeEvent(this.currentIndex);
}

class HomeScreenNamesOfAllahPlayAndPauseEvent
    extends HomeScreenNamesOfAllahEvent {
  final int nameIndex;

  HomeScreenNamesOfAllahPlayAndPauseEvent(this.nameIndex);
}

class HomeScreenNamesOfAllahPlayEvent extends HomeScreenNamesOfAllahEvent {}

class HomeScreenNamesOfAllahPauseEvent extends HomeScreenNamesOfAllahEvent {}

class HomeScreenNamesOfAllahIsVolumeOnEvent
    extends HomeScreenNamesOfAllahEvent {}

class HomeScreenNamesOfAllahResetEvent extends HomeScreenNamesOfAllahEvent {
  final int nameIndex;

  HomeScreenNamesOfAllahResetEvent(this.nameIndex);
}

class HomeScreenNamesOfAllahDisposeEvent extends HomeScreenNamesOfAllahEvent {}
