// ignore_for_file: must_be_immutable

part of 'tasbeeh_animation_bloc.dart';

@immutable
abstract class TasbeehAnimationEvent {}

class TasbeehAnimationInitialEvent extends TasbeehAnimationEvent {
  final AnimationController controller;
  TasbeehAnimationInitialEvent(this.controller);
}

class TasbeehAnimationResetEvent extends TasbeehAnimationEvent {}

class TasbeehAnimationLoadedEvent extends TasbeehAnimationEvent {}

class TasbeehAnimationInitialDataSaveEvent extends TasbeehAnimationEvent {}

class TasbeehAnimationSingleDhikrEvent extends TasbeehAnimationEvent {
  final Map singleDhikrData;
  TasbeehAnimationSingleDhikrEvent(this.singleDhikrData);
}

class TasbeehAnimationCounterEvent extends TasbeehAnimationEvent {
  int count;
  TasbeehAnimationCounterEvent({required this.count});
}

class TasbeehAnimationDragEndEvent extends TasbeehAnimationEvent {
  final double details;
  int count;
  TasbeehAnimationDragEndEvent(this.details, this.count);
}

class TasbeehSoundEvent extends TasbeehAnimationEvent {
  int count;
  TasbeehSoundEvent({required this.count});
}
