part of 'settings_bloc.dart';

abstract class SettingsState {}

 class SettingsLoadingState extends SettingsState {}
 class AzanNotificationState extends SettingsState {
  final bool azanStatus;

  AzanNotificationState({required this.azanStatus});

 }
