import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/pages/Quran_screen/common_widgets/surah_name_card.dart';

class SurahForPrayer extends StatefulWidget {
  const SurahForPrayer({super.key});

  @override
  State<SurahForPrayer> createState() => _SurahForPrayerState();
}

class _SurahForPrayerState extends State<SurahForPrayer> {
  List surahInfo = [];
  List surahForPrayer = [];
  // We don't have index in the `quran-surah-names.json`.
  // So, we need to update `indexOfSurahForPrayer` list if we want to remove or add any surah
  List indexOfSurahForPrayer = [
    0,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    111,
    112,
    113
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    surahInfo = jsonDecode(await rootBundle
        .loadString('assets/json/QuranJson/quran-surah-names.json'));
    surahForPrayer = [...surahInfo];
    // Remove elements from index 1 to 100
    surahForPrayer.removeRange(1, 101);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 246, 246, 246),
      child: ListView.builder(
        itemCount: surahForPrayer.length,
        itemBuilder: (BuildContext context, int index) {

          return surahNameCard(
              surahInfo[indexOfSurahForPrayer[index]], context, indexOfSurahForPrayer[index]);
        },
      ),
    );
  }
}
