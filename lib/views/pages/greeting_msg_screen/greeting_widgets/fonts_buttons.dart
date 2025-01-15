
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim_vision/blocs/greetings_blocs/greetings_edit_bloc/greetings_share_edit_bloc.dart';

import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle fontFamily;


  const CustomButton({super.key, required this.text, required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
           BlocProvider.of<GreetingsShareEditBloc>(context).add(TextOffsetEvent(fontFamaly: fontFamily));
      },
      style: TextButton.styleFrom(
        padding:  EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
        textStyle: TextStyle(fontSize: 16.sp,color: Colors.white),
        
      ),
      child: Text(
        text,
        style:fontFamily.copyWith(
          color: kColorGreen
        )

        
        //  GoogleFonts.getFont(fontFamily, color: Colors.white),
      ),
    );
  }
}