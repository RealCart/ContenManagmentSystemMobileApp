part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class ExitAppEvent extends SettingsEvent {
  const ExitAppEvent({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

final class ToggleModeEvent extends SettingsEvent {
  const ToggleModeEvent(this.mode);

  final ThemeMode mode;

  @override
  List<Object> get props => [mode];
}
