// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';

part 'greetings_share_edit_event.dart';
part 'greetings_share_edit_state.dart';

class GreetingsShareEditBloc extends Bloc<GreetingsShareEditEvent, GreetingsShareEditState> {
  GreetingsShareEditBloc() : super(GreetingsShareEditInitial()) {
    // ------------------initialize variable --------------------

    Offset offset = const Offset(0, 0);
    double fontsize = 0.0;
    Offset imgOffset = const Offset(0, 0);
    double opacity = 0.0;
    Color color = Colors.white;
    Color tcolor = Colors.white;
    double topacity = 0.0;
    //  TextStyle textStyle=GoogleFonts.habibi(); // enable it when on google font
    TextStyle textStyle = const TextStyle(); // delete google font thats why
    double imghight = 0.0;

    // ------------Image Edit--------------------

    on<ImageOffsetEvent>((event, emit) {
      imgOffset = event.imageoffest ?? imgOffset;
      opacity = event.opacityValue ?? opacity;
      color = event.color ?? color;
      imghight = event.height ?? imghight;

      //rint(event.imageoffest);
      emit(ImageOffsetState(imageoffset: imgOffset, opacityValue: opacity, color: color, height: imghight));
    });

    // ========== text edit ===============

    on<TextOffsetEvent>((event, emit) {
      offset = event.textOffset ?? offset;
      fontsize = event.fontSize ?? fontsize;
      tcolor = event.textcolor ?? tcolor;
      topacity = event.opacityValue ?? topacity;
      textStyle = event.fontFamaly ?? textStyle;

      emit(TextOffsetState(textoffset: offset, fontsize: fontsize, fontFamily: textStyle, opacityValue: topacity, color: tcolor));
    });

    //================ Greetings Share Event

    on<ShareImageEvent>((event, emit) async {
      CommonFunctions().shareImage(event.imgkey);
    });
  }
}
