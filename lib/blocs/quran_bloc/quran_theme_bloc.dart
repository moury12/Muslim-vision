// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muslim_vision/database/boxes.dart';

part 'quran_theme_event.dart';
part 'quran_theme_state.dart';

class QuranThemeBloc extends Bloc<QuranThemeEvent, QuranThemeState> {
  QuranThemeBloc() : super(QuranThemeState(Boxes().themeBox.get('font-size', defaultValue: 0.5), Boxes().themeBox.get('is_dark', defaultValue: false))) {
    on<ToggleTheme>((event, emit) {
      Boxes().themeBox.put('is_dark', event.isDarkMode);
      emit(state.copyWith(isDarkMode: event.isDarkMode));
    });
    on<UpdateFontSize>((event, emit) {
      Boxes().themeBox.put('font-size', event.fontSize);
      emit(state.copyWith(progressValue: event.fontSize));
    });
  }
}
