// ignore_for_file: depend_on_referenced_packages

import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_top_card_zone_bloc/prohibited_time_manager.dart';
import 'package:muslim_vision/database/boxes.dart';

import '../../../controllers/services/common_functions.dart';

part 'prohibeted_prayer_event.dart';
part 'prohibeted_prayer_state.dart';

class ProhibetedPrayerBloc extends Bloc<ProhibetedPrayerEvent, ProhibetedPrayerState> {
  ProhibetedPrayerBloc() : super(ProhibetedPrayerInitial()) {
    on<ProhibetedPrayerLoadedEvent>((event, emit) {
      final utilBox = Boxes().utilsBox;
      if (utilBox.get('lat') == null || utilBox.get('long') == null) {
        return emit(ProhibetedPrayerNoLocationState());
      } else {
        if (utilBox.keys.isNotEmpty) {
          double lat = double.parse(utilBox.get('lat').toString());
          double long = double.parse(utilBox.get('long').toString());
          PrayerTimes prayerTimes = CommonFunctions.getPrayerTime(lat, long, DateTime.now());
          DateTime sunrise = prayerTimes.sunrise;
          DateTime sunset = prayerTimes.maghrib;
          ProhibitedPrayerTimeManager manager = ProhibitedPrayerTimeManager(
            sunrise: sunrise,
            sunset: sunset,
          );

          emit(ProhibetedPrayerLoadedState(prohibitedPrayerList: manager.getProhibitedTimes()));
          if (event.isSunrise == true) {
            emit(ProhibetedPrayerLoadedState(prohibitedPrayerList: manager.getProhibitedTimes(), isProhibited: const [true, false, false]));
          }
          if (event.isZenith == true) {
            emit(ProhibetedPrayerLoadedState(prohibitedPrayerList: manager.getProhibitedTimes(), isProhibited: const [false, true, false]));
          }
          if (event.isSunset == true) {
            emit(ProhibetedPrayerLoadedState(prohibitedPrayerList: manager.getProhibitedTimes(), isProhibited: const [false, false, true]));
          }
        }
      }
    });
  }
}
