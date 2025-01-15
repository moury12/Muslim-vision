import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar aweSomeSnackBar(
    {required String title,
    required String subTitle,
    required ContentType contentType,
    required int duration}) {
  return SnackBar(
    duration: Duration(milliseconds: duration),
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,


    content: AwesomeSnackbarContent(

      title: title,
      message: subTitle,
      contentType: contentType,
      titleTextStyle: TextStyle(fontSize: 16.sp),
      messageTextStyle: TextStyle(fontSize: 12.sp),

    ),
  );
}
