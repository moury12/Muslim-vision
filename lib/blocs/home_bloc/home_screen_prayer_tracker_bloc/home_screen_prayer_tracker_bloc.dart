// ignore_for_file: depend_on_referenced_packages

import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/database/boxes.dart';

import '../../../controllers/services/common_functions.dart';

part 'home_screen_prayer_tracker_event.dart';
part 'home_screen_prayer_tracker_state.dart';

DateTime dtNow =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

class HomeScreenPrayerTrackerBloc
    extends Bloc<HomeScreenPrayerTrackerEvent, HomeScreenPrayerTrackerState> {
  List<String> getFiveTimesPrayer(double lat, double long) {
    /*-------------------------get data from adhan package----------------------*/
    PrayerTimes prayerTimes =
        CommonFunctions.getPrayerTime(lat, long, DateTime.now());
    /*-------------------------Five wakt prayer details----------------------*/
    List<String> fiveTimesPrayer = [];
    fiveTimesPrayer.add(DateFormat('h:mm a').format(prayerTimes.fajr));
    fiveTimesPrayer.add(DateFormat('h:mm a')
        .format(prayerTimes.dhuhr.add(const Duration(minutes: 5))));
    fiveTimesPrayer.add(DateFormat('h:mm a').format(prayerTimes.asr));
    fiveTimesPrayer.add(DateFormat('h:mm a').format(prayerTimes.maghrib));
    fiveTimesPrayer.add(DateFormat('h:mm a').format(prayerTimes.isha));
    fiveTimesPrayer.add(DateFormat('h:mm a').format(prayerTimes.sunrise));

    return fiveTimesPrayer;
  }

  HomeScreenPrayerTrackerBloc() : super(HomeScreenPrayerTrackerInitialState()) {
    Box salatTrackerBox = Hive.box('salatTrackerBox');
    late DateTime selectDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    //  Map<dynamic, Map<dynamic, dynamic>> salatTrack(Box box) {// Old Data type  Map<String, Map<String, bool>>
    //   Map<dynamic, Map<dynamic, dynamic>> result = {};

    //   for (String key in box.keys) {
    //     result[key] = box.get(key);
    //   }
    //   return result;
    // }

    List<bool> getRakatList(Box box, String dt) {
      bool getData(String key) {
        if (box.get(dt) == null || box.get(dt)[key] == null) {
          return false;
        }
        final result = box.get(dt)[key] ?? false;
        return result;
      }

      return [
        getData('f'),
        getData('j'),
        getData('a'),
        getData('m'),
        getData('e'),
        getData('t'),
      ];
    }

    final utilBox = Boxes().utilsBox;
    // double? lat = utilBox.get('lat');
    // double? long = utilBox.get('long');
    on<HomeScreenPrayerTrackerLoadedEvent>((event, emit) async {
      emit(HomeScreenPrayerTrackerInitialState());
      // Check if Hive has the previous location data
      // If available, display the time details based on the previous state
      // This helps prevent unnecessary loading by using cached data

      if (utilBox.get('lat') == null || utilBox.get('long') == null) {
        emit(HomeScreenPrayerTrackerNoLocationState());
      } else {
        emit(HomeScreenPrayerTrackerLoadedState(
            waktTimes:
                getFiveTimesPrayer(utilBox.get('lat'), utilBox.get('long')),
            rakat: getRakatList(salatTrackerBox, selectDate.toString())));
      }
      // /*-------------------------get user location----------------------*/
      // Position currentPosition = await CommonFunctions().determinePosition();
      // lat = currentPosition.latitude;
      // long = currentPosition.longitude;
      //
      // // Save the location to Hive for future reference
      // utilBox.put('lat', lat);
      // utilBox.put('long', long);
      // emit(HomeScreenPrayerTrackerLoadedState(waktTimes: getFiveTimesPrayer(currentPosition.latitude, currentPosition.longitude), rakat: getRakatList(salatTrackerBox, selectDate.toString())));
    });

    on<PrayerButtonEvent>((event, emit) async {
      //set value
      if (salatTrackerBox.get(selectDate.toString()) == null) {
        await salatTrackerBox.put(selectDate.toString(), {event.key: false});
      }

      Map<dynamic, dynamic> map = salatTrackerBox.get(selectDate.toString());
      map[event.key] = !(map[event.key] ?? false);

      await salatTrackerBox.put(selectDate.toString(), map);

      emit(HomeScreenPrayerTrackerLoadedState(
          waktTimes:
              getFiveTimesPrayer(utilBox.get('lat'), utilBox.get('long')),
          rakat: getRakatList(salatTrackerBox, selectDate.toString())));
    });
  }
}
