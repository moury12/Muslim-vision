// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'greetings_share_edit_bloc.dart';

@immutable
abstract class GreetingsShareEditEvent {}

class ImageOffsetEvent extends GreetingsShareEditEvent {
  Offset? imageoffest;
   double? opacityValue;
   Color ?color;
   double ? height;
  ImageOffsetEvent({
     this.imageoffest,
    this.opacityValue,
    this.color,
    this.height
  });
}

class TextOffsetEvent extends GreetingsShareEditEvent {
  Offset? textOffset;
  double? fontSize;
  TextStyle? fontFamaly;
   double? opacityValue;
  Color? textcolor;

  TextOffsetEvent({
    this.textOffset,
    this.fontSize,
    this.fontFamaly,
    this.textcolor,
    this.opacityValue
  });
}



class ColorWidgetShowEvent extends GreetingsShareEditEvent{

}

//! Greetings Share Event ****

class ShareImageEvent extends GreetingsShareEditEvent {
  GlobalKey imgkey;
  ShareImageEvent({required this.imgkey});
}
