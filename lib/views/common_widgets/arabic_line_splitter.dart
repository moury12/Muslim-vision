import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/light_theme. dart.dart';

Widget arabicLineSplitter(String text, {TextStyle? textStyleForBangla}) {
  textStyleForBangla ?? kStyleTextW400CB.copyWith(fontSize: 16.sp);
  final RegExp arabic = RegExp(r'^[\u0621-\u064A]+');
  final RegExp numeric = RegExp(r'^[0-9a-zA-Z«»]');

  bool hasArabicText(String t) => arabic.hasMatch(t) || numeric.hasMatch(t) == true;
  return Column(
      children: LineSplitter.split(text).map((t) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text("1 "),
        Expanded(
          child: Text(
            t,
            style: hasArabicText(t) ? const TextStyle(fontFamily: "Naskh", color: kColorBlack, fontWeight: FontWeight.w400).copyWith(fontSize: 25.sp) : textStyleForBangla,
            textAlign: hasArabicText(t) == true ? TextAlign.right : TextAlign.justify,
          ),
        )
      ],
    );
  }).toList());
}
