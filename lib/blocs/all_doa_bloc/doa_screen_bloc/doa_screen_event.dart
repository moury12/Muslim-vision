part of 'doa_screen_bloc.dart';

@immutable
abstract class DoaScreenEvent {}

class DoaScreenLoadedEvent extends DoaScreenEvent {}

class DoaScreenLoadedRamadanEvent extends DoaScreenEvent {}
