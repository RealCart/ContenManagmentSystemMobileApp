import 'package:instai/features/settings/data/sources/locale/settings_locale.dart';
import 'package:instai/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(SettingsLocale locale) : _locale = locale;

  final SettingsLocale _locale;

  @override
  Future<void> clearCache() async {
    await _locale.clearCache();
  }

  @override
  Future<bool?> getThemeIsDark() {
    return _locale.readThemeIsDark();
  }

  @override
  Future<void> saveThemeIsDark(bool isDark) {
    return _locale.saveThemeIsDark(isDark);
  }
}
