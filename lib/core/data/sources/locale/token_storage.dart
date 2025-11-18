import 'package:instai/core/constants/app_constants.dart';
import 'package:instai/core/data/sources/locale/secure_storage.dart';

abstract interface class TokenStorage {
  Future<void> writeToken(String value);
  Future<void> clearToken();
  Future<String?> getToken();
  Future<bool> containsToken();
}

class TokenStorageImpl implements TokenStorage {
  const TokenStorageImpl(SecureStorage storage) : _storage = storage;

  final SecureStorage _storage;

  @override
  Future<void> clearToken() async {
    await _storage.delete(key: AppConstants.tokenKey);
  }

  @override
  Future<String?> getToken() async {
    return _storage.read(key: AppConstants.tokenKey);
  }

  @override
  Future<void> writeToken(String value) async {
    await _storage.write(key: AppConstants.tokenKey, value: value);
  }

  @override
  Future<bool> containsToken() async {
    final String? token = await getToken();

    if (token != null && token.trim().isNotEmpty) {
      return true;
    }

    return false;
  }
}
