import 'package:flutter/material.dart';

String convertToBanglaNumber(String englishNumber) {
  Map<String, String> banglaNumberMap = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  String banglaNumber = '';
  for (int i = 0; i < englishNumber.length; i++) {
    String digit = englishNumber[i];
    banglaNumber += banglaNumberMap[digit] ?? digit;
  }
  return banglaNumber;
}
String convertToEnglishNumber(String banglaNumber) {
  Map<String, String> englishNumberMap = {
     '০':'0',
     '১':'1',
     '২':'2',
     '৩':'3',
     '৪':'4',
     '৫':'5',
     '৬':'6',
     '৭':'7',
     '৮':'8',
     '৯':'9',
  };

  String englishNumber = '';
  for (int i = 0; i < banglaNumber.length; i++) {
    String digit = banglaNumber[i];
    englishNumber += englishNumberMap[digit] ?? digit;
  }
  debugPrint(englishNumber);
  return englishNumber;
}
