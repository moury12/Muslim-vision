import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class RamadanCardSection extends StatefulWidget {
  const RamadanCardSection({super.key});

  @override
  State<RamadanCardSection> createState() => _RamadanCardSectionState();
}

class _RamadanCardSectionState extends State<RamadanCardSection> {
  final utilsBox = Boxes().utilsBox;
  String sahariTime = '';
  String iftarTime = '';

  _sahriIftarTime() {
    final lat = utilsBox.get('lat');
    final long = utilsBox.get('long');
    DateTime dateTime = DateTime.now();
    final prayerTimes = CommonFunctions.getPrayerTime(lat, long, dateTime);
    sahariTime = DateFormat('h:mm a').format(prayerTimes.fajr);
    iftarTime = DateFormat('h:mm a').format(prayerTimes.maghrib);
    // Extending 3 minutes for BD only
    if (prayerTimes.maghrib.timeZoneName == '+06') {
      iftarTime = DateFormat('h:mm a').format(prayerTimes.maghrib.add(const Duration(minutes: 3)));
    }
  }

  int day = 0;
  String monthPart = "";

  _arabicDateTime() async {
    DateTime date = DateTime.now().subtract(const Duration(days: 1));
    String todayDateHijri = HijriCalendar.fromDate(date).toFormat('dd MMMM yyyy');
    List<String> parts = todayDateHijri.split(' ');
    day = int.parse(parts[0]);
    monthPart = parts[1];
    //monthPart = "Shawwal";
    //print("monthPart:$monthPart");
    // day = int.tryParse(dayPart)!;
    //day = 1;
    /*if ((day > 1 && monthPart == "Ramadan") || (day <= 29 && monthPart == "Ramadan")) {
      day = day - 1;
      return;
    } else if (day == 1 && monthPart != "Ramadan") {
      day = 29;
      monthPart = "Ramadan";
      return;
    } else if (day == 30 && monthPart == "Ramadan") {
      day = 29;
      return;
    } else if (day == 1 && monthPart != "Ramadan") {
      day = 30;
      monthPart = "Ramadan";
      return;
    }else{
      day = 30;
    }*/

    // if ((day > 1 && day <= 29 && monthPart == "Ramadan")) {
    //   day = day - 1;
    // } else if (day == 1 && monthPart != "Ramadan" && (utilBox.get('day30') == null ? 0 : int.parse(utilBox.get('day30'))) <= 29) {
    //   day = 29;
    //   monthPart = "Ramadan";
    // } else if (day == 30 && monthPart == "Ramadan" && utilBox.get('day30') == null) {
    //   await utilBox.put('day30', '30');
    //   day = 29;
    // } else if (day == 1 && monthPart != "Ramadan" && int.parse(utilBox.get('day30')) == 30) {
    //   day = 30;
    //   monthPart = "Ramadan";
    // } else {
    //   day = 30;
    // }
  }

  String getSuperscriptDate(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  void initState() {
    super.initState();
    if (utilsBox.get('lat') != null || utilsBox.get('long') != null) {
      _sahriIftarTime();
    }
    _arabicDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(padding: EdgeInsets.fromLTRB(6.5.w, 0.h, 6.5.w, 8.w), width: double.infinity, height: deviceHeight * 0.18.h, color: Colors.white, child: Image.asset(fit: BoxFit.fill, "assets/images/ramadan_card.jpg")
            // const VectorGraphic(
            //   fit: BoxFit.fill,
            //   loader: AssetBytesLoader(
            //     '$ramadanCard.vec',
            //   ),
            // )
            //     SvgPicture.asset(
            //   ramadanCard,
            //   fit: BoxFit.fill,
            // ),
            ),
        Positioned(
            top: 30.h,
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      day.toString(),
                      style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getSuperscriptDate(day).toString(),
                      style: kStyleTextW600CW.copyWith(fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text(" "),
                Text(
                  monthPart,
                  style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ],
            )),

        ///************************************sahari time***************************************
        Positioned(
            bottom: 30.h,
            left: 110.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'sahari_time'.tr(),
                  style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  sahariTime,
                  style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.normal),
                )
              ],
            )),

        ///***********************************sahari time****************************************
        ///**********************************iftar time*****************************************
        Positioned(
            bottom: 30.h,
            right: 78.w,
            child: Column(
              children: [
                Text(
                  'iftar_time'.tr(),
                  style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  iftarTime,
                  style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.normal),
                )
              ],
            )),
        // Positioned(
        //     bottom: 30,
        //     right: 75,
        //     child: Text(
        //       iftarTime,
        //       style: kStyleTextW600CW.copyWith(height: 1, fontSize: 14.sp, fontWeight: FontWeight.normal),
        //     )),

        ///************************************iftar time***************************************
      ],
    );
  }
}
