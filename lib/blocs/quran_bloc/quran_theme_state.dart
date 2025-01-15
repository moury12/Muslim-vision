part of 'quran_theme_bloc.dart';

@immutable
class QuranThemeState {
  final double progressValue;
  final bool isDarkMode;
  static const double minFontSize = 20;
  static const double maxFontSize = 40;
  double get fontSize =>
      minFontSize + (progressValue * (maxFontSize - minFontSize));

  const QuranThemeState(this.progressValue, this.isDarkMode);
  QuranThemeState copyWith({double? progressValue, bool? isDarkMode}) {
    return QuranThemeState(
        progressValue ?? this.progressValue, isDarkMode ?? this.isDarkMode);
  }
}
