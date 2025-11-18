abstract interface class SettingsRepository {
  Future<void> clearCache();
  Future<void> saveThemeIsDark(bool isDark);
  Future<bool?> getThemeIsDark();
} 