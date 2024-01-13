import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_theme.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState(ThemeMode.light)) {
    on<AppThemeChanged>(_onAppThemeChanged);
  }

  void _onAppThemeChanged(AppThemeChanged event, Emitter<AppState> emit) {
    emit(AppState(event.themeMode));
  }
}
