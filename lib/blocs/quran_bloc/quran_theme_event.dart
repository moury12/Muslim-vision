part of 'quran_theme_bloc.dart';

@immutable
abstract class QuranThemeEvent {}

class UpdateFontSize extends QuranThemeEvent {
  final double fontSize;

  UpdateFontSize(this.fontSize);
}

class ToggleTheme extends QuranThemeEvent {
  final bool isDarkMode;

  ToggleTheme(this.isDarkMode);
}
