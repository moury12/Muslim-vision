part of 'more_screen_bloc.dart';

abstract class MoreScreenState extends Equatable {
  const MoreScreenState();

  @override
  List<Object> get props => [];
}

class MoreScreenInitial extends MoreScreenState {}

class MoreScreenLoadedState extends MoreScreenState {
  final String version;
  const MoreScreenLoadedState({required this.version});
}
