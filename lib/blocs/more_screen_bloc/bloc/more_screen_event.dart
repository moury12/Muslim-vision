part of 'more_screen_bloc.dart';

abstract class MoreScreenEvent extends Equatable {
  const MoreScreenEvent();

  @override
  List<Object> get props => [];
}


class MoreScreenLoadEvent extends MoreScreenEvent {}