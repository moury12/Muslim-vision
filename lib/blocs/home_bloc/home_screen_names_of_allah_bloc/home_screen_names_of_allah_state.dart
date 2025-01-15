part of 'home_screen_names_of_allah_bloc.dart';

@immutable
abstract class HomeScreenNamesOfAllahState {}

class HomeScreenNamesOfAllahInitialState extends HomeScreenNamesOfAllahState {}

class HomeScreenNamesOfAllahLoadedState extends HomeScreenNamesOfAllahState {
  final List namesOfAllah;

  HomeScreenNamesOfAllahLoadedState(this.namesOfAllah);
}

class HomeScreenNamesOfAllahIsPlayingState extends HomeScreenNamesOfAllahState {
  final bool isPlaying;

  HomeScreenNamesOfAllahIsPlayingState(this.isPlaying);
}

class HomeScreenNamesOfAllahIsStopState extends HomeScreenNamesOfAllahState {
  final bool isStop;

  HomeScreenNamesOfAllahIsStopState(this.isStop);
}

class HomeScreenNamesOfAllahIsVolumeOnState extends HomeScreenNamesOfAllahState {
  final bool isVolumeOn;

  HomeScreenNamesOfAllahIsVolumeOnState(this.isVolumeOn);
}
