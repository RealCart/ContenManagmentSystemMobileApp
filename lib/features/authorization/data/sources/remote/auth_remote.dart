import 'package:instai/core/constants/app_api.dart';
import 'package:instai/core/data/sources/remote/http_client.dart';
import 'package:instai/features/authorization/data/models/auth_model.dart';
import 'package:instai/features/authorization/data/models/form_params_model.dart';

abstract interface class AuthRemote {
  Future<AuthModel> signInUser(FormParamsModel params);
  Future<AuthModel> signUpUser(FormParamsModel params);
}

class AuthRemoteImpl implements AuthRemote {
  const AuthRemoteImpl(HttpClient http) : _http = http;

  final HttpClient _http;

  @override
  Future<AuthModel> signInUser(FormParamsModel params) async {
    final response = await _http.post(AppApi.signIn, data: params);

    return AuthModel.fromJson(response.data);
  }

  @override
  Future<AuthModel> signUpUser(FormParamsModel params) async {
    final response = await _http.post(AppApi.signUp, data: params);

    return AuthModel.fromJson(response.data);
  }
}
