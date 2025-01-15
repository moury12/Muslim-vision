import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muslim_vision/database/boxes.dart';
part 'prayer_screen_event.dart';
part 'prayer_screen_state.dart';

DateTime dtNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

class PrayerScreenBloc extends Bloc<PrayerScreenEvent, PrayerScreenState> {
  PrayerScreenBloc() : super(PrayerScreenInitial()) {
    //

    Box salatTrackerBox = Hive.box('salatTrackerBox');
    late DateTime selectDate;

    Map<dynamic, Map<dynamic, dynamic>> salatTrack(Box box) {
      // Old Data type  Map<String, Map<String, bool>>
      Map<dynamic, Map<dynamic, dynamic>> result = {};

      for (String key in box.keys) {
        result[key] = box.get(key);
      }
      List<String> keysToRemove = []; //for delete keys whos are after the curret tiem

      for (var key in box.keys) {
        //for delete keys whos are after the curret tiem
        if (DateTime.parse(key.toString()).isAfter(dtNow)) {
          keysToRemove.add(key);
        }
      }

      for (var key in keysToRemove) {
        //for delete keys whos are after the curret tiem
        box.delete(key);
      }

      return result;
    }

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

//--------------------------------------------------------------------

    String? getCity() {
      final utilBox = Boxes().utilsBox;
      return utilBox.get('city');
    }

    //city loading
    on<PrayerCityLoadingEvent>((event, emit) async {
      emit(PrayerLoadingState());
      final String? city = getCity();
      emit(PrayerCityLoadedState(city.toString()));
    });

    //loading state
    on<PrayerCalendarButtonLoadingEvent>((event, emit) async {
      selectDate = dtNow;

      emit(PrayerButtonsState(getRakatList(salatTrackerBox, selectDate.toString()), selectDate));
      emit(PrayerCalendarState(salatTrack(salatTrackerBox), selectDate));
    });

    //toggle
    on<PrayerCityCalendarToggleEvent>((event, emit) async {
      emit(PrayerCalendarState(salatTrack(salatTrackerBox), selectDate));
    });

    //date click
    on<PrayerDateClickEvent>((event, emit) async {
      selectDate = event.selectDateEvent;
      emit(PrayerCalendarState(salatTrack(salatTrackerBox), selectDate));
      emit(PrayerButtonsState(getRakatList(salatTrackerBox, selectDate.toString()), selectDate));
    });

    //button
    on<PrayerButtonEvent>((event, emit) async {
      //set value
      if (salatTrackerBox.get(selectDate.toString()) == null) {
        await salatTrackerBox.put(selectDate.toString(), {event.key: false});
      }

      Map<dynamic, dynamic> map = salatTrackerBox.get(selectDate.toString());
      map[event.key] = !(map[event.key] ?? false);
      await salatTrackerBox.put(selectDate.toString(), map);
      emit(PrayerButtonsState(getRakatList(salatTrackerBox, selectDate.toString()), selectDate));
      emit(PrayerCalendarState(salatTrack(salatTrackerBox), selectDate));
    });
    on<DisableTrackClickEvent>((event, emit) => emit(DisableButtonsState()));
  }
}
