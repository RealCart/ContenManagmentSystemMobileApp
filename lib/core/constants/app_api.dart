class AppApi {
  static const String baseBaseUrl =
      "https://cms-production-d847.up.railway.app";
  static const String baseUrl = "$baseBaseUrl/api";

  static const String signUp = "/auth/register";
  static const String signIn = "/auth/login";
  static const String usersMe = "/users/me";
  static const String posts = "/posts";
  static const String postGenerate = "/posts/generate";
  static const String postSave = "/posts/save";
}
