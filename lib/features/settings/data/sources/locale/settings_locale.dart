import 'package:instai/core/constants/app_constants.dart';
import 'package:instai/core/data/sources/locale/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsLocale {
  Future<void> clearCache();
  Future<void> saveThemeIsDark(bool isDark);
  Future<bool?> readThemeIsDark();
}

class SettingsLocaleImpl implements SettingsLocale {
  const SettingsLocaleImpl(
    SharedPreferencesWithCache prefs,
    TokenStorage tokenStorage,
  ) : _prefs = prefs,
       _tokenStorage = tokenStorage;

  final SharedPreferencesWithCache _prefs;
  final TokenStorage _tokenStorage;

  @override
  Future<void> clearCache() async {
    await _tokenStorage.clearToken();
  }

  @override
  Future<bool?> readThemeIsDark() async {
    return _prefs.getBool(AppConstants.themeIsDarkKey);
  }

  @override
  Future<void> saveThemeIsDark(bool isDark) async {
    await _prefs.setBool(AppConstants.themeIsDarkKey, isDark);
  }
}
