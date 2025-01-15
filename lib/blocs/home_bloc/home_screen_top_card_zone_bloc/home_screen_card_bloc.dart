// ignore_for_file: depend_on_referenced_packages

import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_top_card_zone_bloc/prohibited_time_manager.dart';
import '../../../controllers/services/common_functions.dart';
import '../../../database/boxes.dart';

part 'home_screen_card_event.dart';

part 'home_screen_card_state.dart';

class HomeScreenCardBloc extends Bloc<HomeScreenCardEvent, HomeScreenCardState> {
  Map<String, dynamic> getCurrentWaktDetails(double? lat, double? long) {
    PrayerTimes prayerTimes = CommonFunctions.getPrayerTime(lat!, long!, DateTime.now());
    DateTime sunrise = prayerTimes.sunrise;
    DateTime sunriseEnd = sunrise.add(const Duration(minutes: 15));

    DateTime sunset = prayerTimes.maghrib;
    DateTime zenith = sunrise.add(
      Duration(milliseconds: (sunset.difference(sunrise).inMilliseconds ~/ 2)),
    );
    DateTime zenithStart = zenith.subtract(const Duration(minutes: 5));
    DateTime zenithEnd = zenith.add(const Duration(minutes: 5));

    ProhibitedPrayerTimeManager manager = ProhibitedPrayerTimeManager(
      sunrise: sunrise,
      sunset: sunset,
    );
    if (DateTime.now().isAfter(prayerTimes.isha) || prayerTimes.isha.isAtSameMomentAs(DateTime.now())) {
      prayerTimes = CommonFunctions.getPrayerTime(lat, long, DateTime.now().add(const Duration(days: 1)));
    }
    /*-------------------------Five wakt prayer details----------------------*/
    List<DateTime> fiveTimesPrayer = [];
    fiveTimesPrayer.add(prayerTimes.fajr);
    fiveTimesPrayer.add(prayerTimes.dhuhr);
    fiveTimesPrayer.add(prayerTimes.asr);
    fiveTimesPrayer.add(prayerTimes.maghrib);
    fiveTimesPrayer.add(prayerTimes.isha);
    fiveTimesPrayer.add(prayerTimes.sunrise);
    // fiveTimesPrayer.add(prayerTimes.);
    //print(fiveTimesPrayer);

    List<Map<String, dynamic>> getWaktDetails = [
      {
        'waqtName': 'Fazr',
        'waqtTime': DateFormat('h:mm a').format(fiveTimesPrayer[0]),
        'waqtTimeLeft': sunrise,
        'totalRakat': '4',
        'is_prohibited': false,
        'farz': '2',
        'sunnah': '2',
      },
      {
        'waqtName': 'Duhur',
        'waqtTime': DateFormat('h:mm a').format(zenithEnd),
        'waqtTimeLeft': fiveTimesPrayer[2],
        'is_prohibited': false,
        'totalRakat': '10',
        'farz': '4',
        'sunnah': '6 (4+2)',
      },
      {
        'waqtName': 'Asr',
        'waqtTime': DateFormat('h:mm a').format(fiveTimesPrayer[2]),
        'waqtTimeLeft': sunset.subtract(const Duration(minutes: 15)),
        'is_prohibited': false,
        'totalRakat': '8',
        'farz': '4',
        'sunnah': '4',
      },
      {
        'waqtName': 'Magrib',
        'waqtTime': DateFormat('h:mm a').format(fiveTimesPrayer[3]),
        'waqtTimeLeft': fiveTimesPrayer[4],
        'is_prohibited': false,
        'totalRakat': '5',
        'farz': '3',
        'sunnah': '2',
      },
      {
        'waqtName': 'Isha',
        'waqtTime': DateFormat('h:mm a').format(fiveTimesPrayer[4]),
        'waqtTimeLeft': /*DateTime.now()*/
            fiveTimesPrayer[0] /*.add(Duration(days: 1))*/,
        'is_prohibited': false,
        'totalRakat': '13',
        'farz': '4',
        'sunnah': '6 (4+2)',
        'bitar': '3',
      },
      {
        'waqtName': 'Sunrise',
        'waqtTime': DateFormat('h:mm a').format(fiveTimesPrayer[5]),
        'waqtTimeLeft': fiveTimesPrayer[5],
        'is_prohibited': false,
        'totalRakat': '13',
        'farz': '4',
        'sunnah': '6 (4+2)',
        'bitar': '3',
      },
      {
        'waqtName': 'salat-ad-duha',
        'waqtTime': DateFormat('h:mm a').format(sunriseEnd),
        'waqtTimeLeft': zenithStart,
        'is_prohibited': false,
        'totalRakat': '-',
        'farz': '-',
        'sunnah': '-',
      },
    ];
    Map<String, dynamic> getCurrentWakt() {
      if (manager.getCurrentProhibitedTime(DateTime.now()) != null) {
        return manager.getCurrentProhibitedTime(DateTime.now())!;
      } else {
        for (int i = 0; i < fiveTimesPrayer.length; i++) {
          if (i != 4) {
            if (DateTime.now().isAfter(fiveTimesPrayer[i]) && DateTime.now().isBefore(fiveTimesPrayer[i + 1])) {
              if (i == 0 && DateTime.now().isAfter(fiveTimesPrayer[5])) {
                getWaktDetails[i] = getWaktDetails[6];
              }

              return getWaktDetails[i];
            }
          } else {
            return getWaktDetails[4];
          }
        }
      }
      return {};
    }

    return getCurrentWakt();
  }

  HomeScreenCardBloc() : super(HomeScreenCardInitialState()) {
    on<HomeScreenCardLoadedEvent>((event, emit) async {
      // emit(HomeScreenCardInitialState());
      final utilBox = Boxes().utilsBox;
      if (utilBox.get('lat') == null || utilBox.get('long') == null) {
        return emit(HomeScreenCardNoLocationState());
      } else {
        if (utilBox.keys.isNotEmpty) {
          double lat = double.parse(utilBox.get('lat').toString());
          double long = double.parse(utilBox.get('long').toString());
          emit(HomeScreenCardLoadedState(getCurrentWaktDetails(lat, long)));
        }
        /*-------------------------get user location----------------------*/
        Position currentPosition = await CommonFunctions().determinePosition();

        emit(HomeScreenCardLoadedState(getCurrentWaktDetails(currentPosition.latitude, currentPosition.longitude)));
      }
    });
    on<HomeScreenCardWaktLeftTimerEvent>((event, emit) async {
      if (event.waqtTimedetails['waqtTimeLeft'] != null) {
        emit(HomeScreenCardLoadedState(event.waqtTimedetails));
      }
    });
  }
}
