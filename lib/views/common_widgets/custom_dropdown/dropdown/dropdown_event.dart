part of 'dropdown_bloc.dart';

abstract class DropdownEvent {}

class DropdownItemSelected extends DropdownEvent {
  final String selectedItem;

  DropdownItemSelected(this.selectedItem);
}
