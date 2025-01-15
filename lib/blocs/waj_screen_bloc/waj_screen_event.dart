part of 'waj_screen_bloc.dart';

@immutable
abstract class WajScreenEvent {}
class WajLoadedEvent extends WajScreenEvent {
  
}
class WajPlayEvent extends WajScreenEvent {
  final String videoUrl ;

  WajPlayEvent(this.videoUrl);
  
}
