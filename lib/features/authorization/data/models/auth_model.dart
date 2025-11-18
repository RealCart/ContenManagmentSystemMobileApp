class AuthModel {
  const AuthModel({required this.token});

  final String token;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(token: json["token"] as String);
  }
}
