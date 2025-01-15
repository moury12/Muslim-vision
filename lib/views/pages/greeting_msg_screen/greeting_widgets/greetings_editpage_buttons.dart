

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class RowButtons extends StatelessWidget {
  RowButtons({
    required this.title,
    required this.icondata,
    required this.onTap,
    super.key,
  });
  String title;
  IconData icondata;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell( 
       highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: 80.h,
        width: 120.w,
        child: Card(
          elevation: 10,
          color:kColorPrimary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icondata, color: kColorWhite),
            
              Text(
                title,
                style: kStyleTextW400CW,
              )
            ],
          ),
        ),
      ),
    );
  }
}
