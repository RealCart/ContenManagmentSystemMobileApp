import 'package:instai/features/settings/domain/repositories/settings_repository.dart';

class ClearCacheUsecase {
  const ClearCacheUsecase(SettingsRepository repository)
    : _repository = repository;

  final SettingsRepository _repository;

  Future<void> call() async {
    await _repository.clearCache();
  }
}
