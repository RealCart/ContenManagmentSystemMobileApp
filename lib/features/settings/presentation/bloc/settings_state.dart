part of 'settings_bloc.dart';

@immutable
final class SettingsState extends Equatable {
  const SettingsState({
    this.status = Status.initial,
    this.mode = ThemeMode.system,
  });

  final Status status;
  final ThemeMode mode;

  SettingsState copyWith({Status? status, ThemeMode? mode}) {
    return SettingsState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object> get props => [status, mode];
}
