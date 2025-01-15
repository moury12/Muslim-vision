// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'greetings_share_edit_bloc.dart';

@immutable
abstract class GreetingsShareEditState {}

class GreetingsShareEditInitial extends GreetingsShareEditState {}

class ImageOffsetState extends GreetingsShareEditState {
  Offset imageoffset;
  double? opacityValue;
  Color ?color;
  double? height;
  ImageOffsetState({
    required this.imageoffset,
    this.opacityValue,
    this.color,
    this.height
  });
}

class TextOffsetState extends GreetingsShareEditState {
  Offset textoffset;
  double? fontsize;
  TextStyle ?fontFamily;
    double? opacityValue;
    Color? color;
  
  

  
  TextOffsetState({
    required this.textoffset,
        this.fontsize,
        this.fontFamily,
      this.opacityValue,
      this.color,
 
    
      
  });
}

//Opacity State


class ColorWidgshowState extends GreetingsShareEditState {
  
}
