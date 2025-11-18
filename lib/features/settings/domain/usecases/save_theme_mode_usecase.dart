import 'package:instai/features/settings/domain/repositories/settings_repository.dart';

class SaveThemeModeUsecase {
  const SaveThemeModeUsecase(this._repository);

  final SettingsRepository _repository;

  Future<void> call(bool isDark) {
    return _repository.saveThemeIsDark(isDark);
  }
}


