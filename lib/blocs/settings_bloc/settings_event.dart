part of 'settings_bloc.dart';


abstract class SettingsEvent {}
class TurnAzanOffEvent extends SettingsEvent{
  final bool toggleValue;
  final BuildContext context;
  TurnAzanOffEvent(this.context, {required this.toggleValue});
}
