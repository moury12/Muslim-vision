// ignore_for_file: depend_on_referenced_packages

import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';

import '../../../database/boxes.dart';

part 'home_screen_top_section_event.dart';

part 'home_screen_top_section_state.dart';

class HomeScreenTopSectionBloc extends Bloc<HomeScreenTopSectionEvent, HomeScreenTopSectionState> {
  HomeScreenTopSectionBloc() : super(HomeScreenTopSectionInitialState()) {
    on<HomeScreenTopSectionLoadedEvent>((event, emit) async {
      emit(HomeScreenTopSectionInitialState());
      /*-------------------------get user location From Hive----------------------*/

      final utilBox = Boxes().utilsBox;
      if (utilBox.get('lat') == null || utilBox.get('long') == null || utilBox.get('city') == null) {
        emit(HomeScreenTopSectionNoLocationState());
      } else {
        double latitude = utilBox.get('lat');
        double longitude = utilBox.get('long');
        String city = utilBox.get('city');
        /*-------------------------get data from adhan package----------------------*/
        final myCoordinates = Coordinates(latitude, longitude);
        final params = CalculationMethod.muslim_world_league.getParameters();
        params.madhab = Madhab.shafi;
        final prayerTimes = PrayerTimes.today(myCoordinates, params);
        /*-------------------------Sahri And Iftar prayer details----------------------*/
        String sunrise = DateFormat.jm().format(prayerTimes.sunrise);
        String sunset = DateFormat.jm().format(prayerTimes.maghrib);
        /*-------------------------Arabic And English Date Time----------------------*/
        //String todayDateHijri = HijriCalendar.now().toFormat('dd MMMM yyyy');

        String todayDateEng = DateFormat('d LLLL, y').format(DateTime.now());
        Map<String, dynamic> topSectionData = {
          'todayDateHijri': await CommonFunctions().arabicDateTime(),
          'todayDateEng': todayDateEng,
          'sunrise': sunrise,
          'sunset': sunset,
          'city': city,
        };
        emit(HomeScreenTopSectionLoadedState(topSectionData));
      }
    });
  }
}
