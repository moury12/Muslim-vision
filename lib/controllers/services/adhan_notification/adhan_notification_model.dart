import 'package:intl/intl.dart';

import '../common_functions.dart';

class AdhanForWakto {
  final bool isAdhanOn;
  final String adhanName;
  const AdhanForWakto({this.adhanName = "azan", this.isAdhanOn = true});
}

class AdhanReminders {
  AdhanForWakto adhanForFajr;
  AdhanForWakto adhanForDhuhr;
  AdhanForWakto adhanForAsr;
  AdhanForWakto adhanForMaghrib;
  AdhanForWakto adhanForIsha;
  double lat;
  double long;

  AdhanReminders({this.adhanForFajr = const AdhanForWakto(), this.adhanForDhuhr = const AdhanForWakto(), this.adhanForAsr = const AdhanForWakto(), this.adhanForMaghrib = const AdhanForWakto(), this.adhanForIsha = const AdhanForWakto(), required this.lat, required this.long});

  List<AdhanReminder> adhanReminders = [];

  String getPrayerTimeInHourMin(DateTime date) {
    final hourAndMin = '${date.hour}:${date.minute}';
    return hourAndMin;
  }

  DateTime getMagribPrayerTimeForBD(DateTime magribTime) {
    // Extending 3 minutes for BD only
    if (magribTime.timeZoneName == '+06') {
      return magribTime.add(const Duration(minutes: 3));
    } else {
      return magribTime;
    }
  }

  initialization() {
    for (var i = 0; i < 10; i++) {
      DateTime dateTime = DateTime.now().add(Duration(days: i));
      final prayerTimes = CommonFunctions.getPrayerTime(lat, long, dateTime);
      if (adhanForFajr.isAdhanOn) {
        adhanReminders
            .add(AdhanReminder(id: 1 + 5 * i, adhan: "fazar_azan", time: prayerTimes.fajr, wakto: 'ফজর ${(DateFormat('h:mm a').format(prayerTimes.fajr))}', waktoDescription: 'যারা আঁধারে (ফজর নামাযে) মসজিদের দিকে হেঁটে যায়, তাদের কেয়ামতের দিন পরিপূর্ণ নূর প্রাপ্তির সুসংবাদ দাও। (আবু দাউদ ৪৯৪)'));
      }
      if (adhanForDhuhr.isAdhanOn) {
        adhanReminders.add(AdhanReminder(
            id: 2 + 5 * i,
            adhan: adhanForDhuhr.adhanName,
            time: prayerTimes.dhuhr.add(const Duration(minutes: 5)),
            wakto: 'জোহর ${(DateFormat('h:mm a').format(prayerTimes.dhuhr))}',
            waktoDescription: '‘সুতরাং তোমরা আল্লাহর পবিত্রতা ও মহিমা ঘোষণা করো সন্ধ্যায় ও প্রভাতে এবং অপরাহ্নে ও জোহরের সময়ে; আর আকাশসমূহ ও পৃথিবীতে সকল প্রশংসা তো তাঁরই। (সুরা রুম: ১৭-১৮)'));
      }
      if (adhanForAsr.isAdhanOn) {
        adhanReminders.add(AdhanReminder(
            id: 3 + 5 * i,
            adhan: adhanForAsr.adhanName,
            time: prayerTimes.asr,
            wakto: "আসর ${(DateFormat('h:mm a').format(prayerTimes.asr))}",
            waktoDescription: 'আবু হুরাইরা (রা.) হতে বর্ণিত হাদিসে রাসুল (সা.) বলেন— তোমাদের কেউ যদি সূর্যাস্তের আগে আসরের নামাজে এক সিজদা পায়, তাহলে সে যেন সালাত পূর্ণ করে নেয়। আর যদি সূর্যোদয়ের আগে ফজরের সালাতের এক সিজদা পায়, তাহলে সে যেন সালাত পূর্ণ করে নেয়।(বুখারি, হাদিস : ৫৫৬) '));
      }
      if (adhanForMaghrib.isAdhanOn) {
        adhanReminders.add(AdhanReminder(
            id: 4 + 5 * i,
            adhan: adhanForMaghrib.adhanName,
            time: getMagribPrayerTimeForBD(prayerTimes.maghrib),
            wakto: "মাগরিব ${(DateFormat('h:mm a').format(prayerTimes.maghrib))}",
            waktoDescription: '‘আর সকাল-সন্ধ্যায় (ফজর ও মাগরিবের সময়ে) আল্লাহর পবিত্রতা ও মহিমা ঘোষণা করো। (নামাজ পড়ো)।’ (সুরা আলে ইমরান: ৪১)'));
      }
      if (adhanForIsha.isAdhanOn) {
        adhanReminders.add(
          AdhanReminder(
              id: 5 + 5 * i,
              adhan: adhanForIsha.adhanName,
              time: DateTime.parse('2024-09-07 04:51:00.000'),
              wakto: "এশা ${(DateFormat('h:mm a').format(prayerTimes.isha))}",
              waktoDescription: 'রাসুল (সা.) বলেছেন, ‘যে ব্যক্তি জামাতের সঙ্গে এশার নামাজ আদায় করল, সে যেন অর্ধেক রাত পর্যন্ত (নফল) নামাজ আদায় করল। আর যে ব্যক্তি ফজরের নামাজ জামাতের সঙ্গে আদায় করল সে যেন সারা রাত জেগে নামাজ আদায় করল।’ (মুসলিম, হাদিস : ১৩৭৭)'),
        );
      }
    }
  }
}

class AdhanReminder {
  int id;
  String adhan;
  String wakto;
  DateTime time;
  String waktoDescription;
  AdhanReminder({required this.id, required this.adhan, required this.wakto, required this.time, required this.waktoDescription});
}
