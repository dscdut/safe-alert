part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppThemeChanged extends AppEvent {
  final ThemeMode themeMode;

  const AppThemeChanged({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
