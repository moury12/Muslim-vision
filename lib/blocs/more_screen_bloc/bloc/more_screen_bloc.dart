// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'more_screen_event.dart';
part 'more_screen_state.dart';

class MoreScreenBloc extends Bloc<MoreScreenEvent, MoreScreenState> {
  MoreScreenBloc() : super(MoreScreenInitial()) {
    on<MoreScreenLoadEvent>((event, emit) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      emit(MoreScreenLoadedState(version: version));
    });
  }
}
