part of 'home_screen_top_section_bloc.dart';

@immutable
abstract class HomeScreenTopSectionState {}

class HomeScreenTopSectionInitialState extends HomeScreenTopSectionState {}
class HomeScreenTopSectionNoLocationState extends HomeScreenTopSectionState {}

class HomeScreenTopSectionLoadedState extends HomeScreenTopSectionState {
  final Map<String, dynamic> topSectionData;

  HomeScreenTopSectionLoadedState(this.topSectionData);
}
