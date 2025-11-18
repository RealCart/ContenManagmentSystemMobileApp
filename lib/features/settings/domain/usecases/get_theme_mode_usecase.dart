import 'package:instai/features/settings/domain/repositories/settings_repository.dart';

class GetThemeModeUsecase {
  const GetThemeModeUsecase(this._repository);

  final SettingsRepository _repository;

  Future<bool?> call() {
    return _repository.getThemeIsDark();
  }
}


