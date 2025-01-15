import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/pages/Quran_screen/surah_detail_screen_old.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';



Widget bookMarkWidget({
  required Map bookMarkSurahInfo,
  required BuildContext context,
  required int surahIndex,
  required dynamic surahInfo,
  required int firstIndex,
}) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: () async {
      final quranData = jsonDecode(
          await rootBundle.loadString('assets/json/QuranJson/quran-ayah.json'));

      final segements = jsonDecode(await rootBundle
          .loadString('assets/json/QuranJson/segments-quran-Alafasy.json'));

      final eachSegmentList =
          segements["Alafasy"][(surahIndex).toString()] as List;

      List<List<String>> finalSeg = [];
      for (int i = 0; i < eachSegmentList.length; i++) {
        List<String> seg = [];
        for (int j = 0; j < eachSegmentList[i].length; j++) {
          String timeString =
              '${eachSegmentList[i][j][2]}:${eachSegmentList[i][j][3]}';
          seg.add(timeString);
        }
        finalSeg.add(seg);
      }

      final banglaText = jsonDecode(await rootBundle
          .loadString('assets/json/QuranJson/quran-bangla-trans.json'));

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurahDetailScreenOld(
                jumpToIndex: bookMarkSurahInfo['ayatIndex'],
                quranTextList: quranData[(surahIndex).toString()],
                segmentList: finalSeg,
                index: surahIndex,
                translationText: banglaText[(surahIndex).toString()],
                singleSurahInfo: {
                  "name_in_bangla":bookMarkSurahInfo['surahName']
                }),
          ),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
      child: Padding(
        padding:
            firstIndex == 0 ? const EdgeInsets.only(top: 12) : EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 253, 255, 254),
              borderRadius: BorderRadius.circular(5)),
          height: 68.h,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${bookMarkSurahInfo['surahName']} ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: const Color(0xFF05B46E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(আয়াত-${convertToBanglaNumber((bookMarkSurahInfo['ayatIndex'] + 1).toString())})',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kColorBlack,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${bookMarkSurahInfo['ayatDetails']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const FittedBox(
                      child: Icon(
                        Icons.delete,
                        color: kColorRed,
                      ),
                    ),
                    onPressed: () async {
                      final quranBox = Boxes().quranBox;
                      final surahAndAyatIndexInBookMark =
                          '$surahIndex:${bookMarkSurahInfo['ayatIndex']}';

                      final existingBookMark =
                          quranBox.get('BookMark', defaultValue: {});
                      final modifiedBookMark = Map.from(existingBookMark);
                      if (modifiedBookMark.containsKey(
                          '$surahIndex:${bookMarkSurahInfo['ayatIndex']}')) {
                        modifiedBookMark.remove(surahAndAyatIndexInBookMark);
                      }
                      await quranBox.put('BookMark', modifiedBookMark);
                    },
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}
