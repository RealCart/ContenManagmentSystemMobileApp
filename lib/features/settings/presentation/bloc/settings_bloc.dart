import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/settings/domain/usecases/clear_cache_usecase.dart';
import 'package:instai/features/settings/domain/usecases/save_theme_mode_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ClearCacheUsecase _clearCacheUsecase;
  final SaveThemeModeUsecase _saveThemeModeUsecase;

  SettingsBloc({
    required ClearCacheUsecase clearCacheUsecase,
    required SaveThemeModeUsecase saveThemeModeUsecase,
  })
    : _clearCacheUsecase = clearCacheUsecase,
      _saveThemeModeUsecase = saveThemeModeUsecase,
      super(const SettingsState()) {
    on<ExitAppEvent>(_onExitApp);
    on<ToggleModeEvent>(_onToggleMode);
  }

  void _onExitApp(ExitAppEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await _clearCacheUsecase.call();
    event.completer?.complete();
    emit(state.copyWith(status: Status.initial));
  }

  void _onToggleMode(ToggleModeEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(mode: event.mode));
    await _saveThemeModeUsecase.call(event.mode == ThemeMode.dark);
  }
}
