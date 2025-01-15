// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

// dropdown_bloc.dart
class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownState()) {
    on<DropdownItemSelected>((event, emit) {
      emit(DropdownState(selectedItem: event.selectedItem));
    });
  }
}
