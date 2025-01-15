import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ProhibitedPrayerTimeManager {
  final DateTime sunrise;
  final DateTime sunset;

  ProhibitedPrayerTimeManager({required this.sunrise, required this.sunset});
  List<Map<String, dynamic>> getProhibitedTimes() {
    DateTime sunriseEnd = sunrise.add(const Duration(minutes: 15));
    DateTime sunsetStart = sunset.subtract(const Duration(minutes: 15));
    DateTime zenith = sunrise.add(
      Duration(milliseconds: (sunset.difference(sunrise).inMilliseconds ~/ 2)),
    );
    DateTime zenithStart = zenith.subtract(const Duration(minutes: 5));
    DateTime zenithEnd = zenith.add(const Duration(minutes: 5));

    return [
      {
        'waqtName': 'prohibited_sunrise',
        'waqtTime': DateFormat('h:mm a').format(sunrise),
        'waqtTimeLeft': sunriseEnd,
        'icon': CupertinoIcons.sunrise,
        'is_prohibited': true,
        'details': 'সূর্য ওঠা শুরু করার সময় থেকে পরিপূর্ণ ভাবে উদয় হওয়ার শেষ হওয়া পর্যন্ত। অ্যাপে এই নিষিদ্ধ সময়ের ব্যাপ্তিকাল ১৫ মিনিট দেখানো হয়েছে।',
        'startTime': sunrise,
        'endTime': sunriseEnd,
        'totalRakat': '-',
        'farz': '-',
        'sunnah': '-',
      },
      {
        'waqtName': 'prohibited_zenith',
        'waqtTime': DateFormat('h:mm a').format(zenithStart),
        'icon': CupertinoIcons.sun_min,
        'waqtTimeLeft': zenithEnd,
        'is_prohibited': true,
        'startTime': zenithStart,
        'endTime': zenithEnd,
        'details': 'এই সময়টি যুহরের ওয়াক্ত শুরুর আগের ৩ মিনিট। কিন্তু বাড়তি সতর্কতার জন্য ইসলামিক ফাউন্ডেশন থেকে যুহরের ওয়াক্ত শুরুর আগের ৬ মিনিট নিষিদ্ধ সময় হিসাবে দেখাতে বলা হয়েছে',
        'totalRakat': '-',
        'farz': '-',
        'sunnah': '-',
      },
      {
        'waqtName': 'prohibited_sunset',
        'waqtTime': DateFormat('h:mm a').format(sunsetStart),
        'waqtTimeLeft': sunset,
        'icon': CupertinoIcons.sunset,
        'details': 'সূর্য অস্ত যাওয়া শুরুর সময় থেকে সূর্য পরিপূর্ণ ভাবে অস্তমিত হওয়া পর্যন্ত। অ্যাপে এই নিষিদ্ধ সময়ের ব্যাপ্তিকাল ১৫ মিনিট দেখানো হয়েছে।',
        'is_prohibited': true,
        'startTime': sunsetStart,
        'endTime': sunset,
        'totalRakat': '-',
        'farz': '-',
        'sunnah': '-',
      },
    ];
  }

  Map<String, dynamic>? getCurrentProhibitedTime(DateTime currentTime) {
    for (var period in getProhibitedTimes()) {
      if (currentTime.isAfter(period['startTime']) && currentTime.isBefore(period['endTime'])) {
        return period;
      }
    }
    return null; // No prohibited time currently
  }
}
