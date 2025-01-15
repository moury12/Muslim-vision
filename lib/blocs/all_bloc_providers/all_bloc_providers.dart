import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_vision/blocs/all_doa_bloc/doa_screen_bloc/doa_screen_bloc.dart';
import 'package:muslim_vision/blocs/all_doa_bloc/doa_search_bloc/doa_search_bloc.dart';

import 'package:muslim_vision/blocs/five_pillars_bloc/five_pillars_bloc.dart';
import 'package:muslim_vision/blocs/greetings_blocs/greetings_bg_bloc/greetings_background_bloc.dart';
import 'package:muslim_vision/blocs/greetings_blocs/greetings_bloc/greetingsbloc_bloc.dart';

import 'package:muslim_vision/blocs/greetings_blocs/greetings_edit_bloc/greetings_share_edit_bloc.dart';

import 'package:muslim_vision/blocs/home_bloc/home_screen_names_of_allah_bloc/home_screen_names_of_allah_bloc.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_prayer_tracker_bloc/home_screen_prayer_tracker_bloc.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_top_section_bloc/home_screen_top_section_bloc.dart';
import 'package:muslim_vision/blocs/home_bloc/prohibited-prayer-bloc/prohibeted_prayer_bloc.dart';
import 'package:muslim_vision/blocs/medicine_alert_bloc/medicine_alert_bloc.dart';
import 'package:muslim_vision/blocs/more_screen_bloc/bloc/more_screen_bloc.dart';
import 'package:muslim_vision/blocs/qubani_bloc/qurbani_bloc.dart';
import 'package:muslim_vision/blocs/quran_bloc/quran-search/quran_search_bloc.dart';
import 'package:muslim_vision/blocs/quran_bloc/quran_theme_bloc.dart';
import 'package:muslim_vision/blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';
import 'package:muslim_vision/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_all_dhikr_bloc/tasbeeh_screen_all_dhikr_bloc.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_create_dhikr_bloc/tasbeeh_screen_new_dhikr_bloc.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_tasbeeh_animation_bloc/tasbeeh_animation_bloc.dart';
import 'package:muslim_vision/blocs/waj_screen_bloc/waj_screen_bloc.dart';
import 'package:muslim_vision/blocs/wudu_procedure_bloc/wudu_procedure_bloc.dart';
import 'package:muslim_vision/blocs/zakat_screen_bloc/zakat_screen_bloc.dart';
import 'package:muslim_vision/views/common_widgets/custom_dropdown/dropdown/dropdown_bloc.dart';

import '../home_bloc/home_screen_top_card_zone_bloc/home_screen_card_bloc.dart';
import '../prayer_screen bloc/bloc/prayer_screen_bloc.dart';

class AllBlocProviders {
  static List getAllBlocProviders = [
    BlocProvider(create: (context) => PrayerScreenBloc()),
    BlocProvider(create: (context) => SplashScreenBloc()),
    BlocProvider(create: (context) => HomeScreenCardBloc()),
    BlocProvider(create: (context) => HomeScreenPrayerTrackerBloc()),
    BlocProvider(create: (context) => HomeScreenTopSectionBloc()),
    BlocProvider(create: (context) => TasbeehAnimationBloc()),
    BlocProvider(create: (context) => TasbeehScreenNewDhikrBloc()),
    BlocProvider(create: (context) => TasbeehScreenAllDhikrBloc()),
    BlocProvider(create: (context) => ZakatScreenBloc()),
    BlocProvider(create: (context) => GreetingsShareEditBloc()),
    BlocProvider(create: (context) => HomeScreenNamesOfAllahBloc()),
    BlocProvider(create: (context) => DoaScreenBloc()),
    BlocProvider(create: (context) => WajScreenBloc()),
    BlocProvider(create: (context) => QurbaniBloc()),
    BlocProvider(create: (context) => WuduProcedureBloc()),
    BlocProvider(create: (context) => GreetingsblocBloc()),
    BlocProvider(create: (context) => FivePillarsBloc()),
    BlocProvider(create: (context) => DoaSearchBloc()),
    BlocProvider(create: (context) => SalahReminderBloc()),
    BlocProvider(create: (context) => GreetingsBackgroundBloc()),
    BlocProvider(create: (context) => MoreScreenBloc()),
    BlocProvider(create: (context) => DropdownBloc()),
    BlocProvider(create: (context) => QuranSearchBloc()),
    BlocProvider(create: (context) => ProhibetedPrayerBloc()),
   BlocProvider(create: (context) => MedicineAlertBloc()),
    BlocProvider(create: (context) => QuranThemeBloc()),
  ];
}
