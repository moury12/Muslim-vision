part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState extends Equatable {}

class SplashScreenInitialState extends SplashScreenState {
  @override
  List<Object?> get props => [DateTime.now().toString()];
}
// class SplashScreenSyncProgressState extends SplashScreenState {
//   final double progress;
//   @override
//   List<Object?> get props => [DateTime.now().toString()];
//   SplashScreenSyncProgressState({required this.progress});
// }

class SplashScreenLoadingState extends SplashScreenState {
  @override
  List<Object?> get props => [];
}

class SplashScreenLoadedState extends SplashScreenState {
  @override
  List<Object?> get props => [DateTime.now().toString()];
}

class SplashScreenMessageState extends SplashScreenState {
  final String msg;
  SplashScreenMessageState({required this.msg});

  @override
  List<Object?> get props => [DateTime.now().toString()];
}

class SplashScreenErrorState extends SplashScreenState {
  final String errorMsg;
  SplashScreenErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [DateTime.now().toString()];
}

// class SplashScreenLocationPermissionState extends SplashScreenState {
//   @override
//   List<Object?> get props => [DateTime.now().toString()];
// }
class SplashScreenSyncState extends SplashScreenState {
  // final double progress;
  final String message;

  SplashScreenSyncState(this.message);
  @override
  List<Object?> get props => [DateTime.now().toString()];
}

class SyncTextUpdated extends SplashScreenState {
  final String message;
  SyncTextUpdated(this.message);

  @override
  List<Object?> get props => throw UnimplementedError();
}

// class SplashScreenNotificationPermissionState extends SplashScreenState {
//   @override
//   List<Object?> get props => [DateTime.now().toString()];
// }
