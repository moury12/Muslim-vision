// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim_vision/blocs/greetings_blocs/greetings_edit_bloc/greetings_share_edit_bloc.dart';

class TextColorButtons extends StatelessWidget {
  Color color;
  BuildContext contexts;
  bool istext;
  TextColorButtons({super.key, required this.color, required this.contexts, required this.istext});

  @override
  Widget build(context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        istext ? BlocProvider.of<GreetingsShareEditBloc>(context).add(TextOffsetEvent(textcolor: color)) : BlocProvider.of<GreetingsShareEditBloc>(context).add(ImageOffsetEvent(color: color));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: CircleAvatar(
          radius: 30.r,
          backgroundColor: color,
        ),
      ),
    );
  }
}
