part of 'tasbeeh_animation_bloc.dart';

@immutable
abstract class TasbeehAnimationState {}

class TasbeehAnimationInitialState extends TasbeehAnimationState {}

class TasbeehAnimationSingleDhikrState extends TasbeehAnimationState {
  final Map singleDhikrData;
  TasbeehAnimationSingleDhikrState(this.singleDhikrData);
}

class TasbeehAnimationCounterState extends TasbeehAnimationState {
  final int counter;
  TasbeehAnimationCounterState(this.counter);
}

class TasbeehAnimationLoopState extends TasbeehAnimationState {
  final int loop;
  TasbeehAnimationLoopState(this.loop);
}

class TasbeehSoundState extends TasbeehAnimationState {
  final int count;
  TasbeehSoundState({required this.count});
}
