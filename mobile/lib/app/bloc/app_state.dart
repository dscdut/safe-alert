part of 'app_bloc.dart';

final Map<ThemeMode, ThemeSheet> themes = {
  ThemeMode.light: ThemeSheet(DefaultThemeConfig()),
  ThemeMode.dark: ThemeSheet(DarkThemeConfig()),
};

class AppState extends Equatable {
  final ThemeMode themeMode;

  ThemeSheet get themeSheet => themes[themeMode]!;

  const AppState(this.themeMode);

  @override
  List<Object> get props => [];
}
