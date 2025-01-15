part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenEvent {}

class SplashScreenLoadedEvent extends SplashScreenEvent {}
class UpdateSyncText extends SplashScreenEvent {
  final String message;
  UpdateSyncText(this.message);
}
// class SplashScreenProgressEvent extends SplashScreenEvent {
//   final double progress;
//   SplashScreenProgressEvent({required this.progress});
// }