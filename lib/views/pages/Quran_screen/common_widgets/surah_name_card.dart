import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/pages/Quran_screen/surah_detail_screen_old.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

Widget surahNameCard(dynamic surahInfo, BuildContext context, int index) {
  final quranBox = Boxes().quranBox;
  String getLastReadAndPlayed(int indx) {
    if (quranBox.get('LastRead') != null) {
      // int lastReadIndx = quranBox.get('LastRead').keys.toList()[0];
      String lastReadSurah = quranBox.get('surah name');
      if (lastReadSurah == surahInfo["name_in_bangla"]) {
        return 'সর্বশেষ পড়েছেন';
      }
      return '';
    }

    return '';
  }

  int getAyatIndex(String surahName) {
    if (quranBox.get('LastRead') != null) {
      String lastReadSurahIndx = quranBox.get('surah name');
      int lastReadAyahIndx = quranBox.get('LastRead');
      if (lastReadSurahIndx == surahName) {
        return lastReadAyahIndx;
      }
      return 0;
    }
    return 0;
  }

  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: () async {
      final quranData = jsonDecode(await rootBundle.loadString('assets/json/QuranJson/quran-ayah.json'));

      final segements = jsonDecode(await rootBundle.loadString('assets/json/QuranJson/segments-quran-Alafasy.json'));

      final eachSegmentList = segements["Alafasy"][(index + 1).toString()] as List;

      List<List<String>> finalSeg = [];
      for (int i = 0; i < eachSegmentList.length; i++) {
        List<String> seg = [];
        for (int j = 0; j < eachSegmentList[i].length; j++) {
          String timeString = '${eachSegmentList[i][j][2]}:${eachSegmentList[i][j][3]}';
          seg.add(timeString);
        }
        finalSeg.add(seg);
      }

      final banglaText = jsonDecode(await rootBundle.loadString('assets/json/QuranJson/quran-bangla-trans.json'));

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurahDetailScreenOld(jumpToIndex: getAyatIndex(surahInfo['name_in_bangla']), quranTextList: quranData[(index + 1).toString()], segmentList: finalSeg, index: index + 1, translationText: banglaText[(index + 1).toString()], singleSurahInfo: surahInfo),
          ),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
      child: Padding(
        padding: index == 0 ? const EdgeInsets.only(top: 12) : EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 253, 255, 254), borderRadius: BorderRadius.circular(5)),
          height: 68.h,
          child: Row(
            children: [
              // Text(surahName),
              Expanded(
                  child: Center(
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFF05B46E),
                  child: Text(
                    '${surahInfo["id"].toString()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              )),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            '${surahInfo["name_in_bangla"]} ',
                            // ${quranBox.get('LastRead') == null &&  quranBox.get('LastRead').? '' : ''}',
                            style: TextStyle(color: const Color(0xFF05B46E), fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            getLastReadAndPlayed(index),
                            style: TextStyle(fontSize: 11.sp, color: kColorRed),
                          )
                        ],
                      ),
                    ),
                    FittedBox(child: Text('${surahInfo["meaning_in_bangla"]}')),
                  ]),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FittedBox(
                        child: Text(
                          '${surahInfo["name_in_arabic"]}',
                          style: TextStyle(fontSize: 26.sp, fontFamily: "Naskh"),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
