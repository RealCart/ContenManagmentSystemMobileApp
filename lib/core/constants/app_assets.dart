class AppAssets {
  static const imgaes = AppImages();
  static const icon = AppIcons();
}

class AppImages {
  const AppImages();

  final String _path = "assets/images";

  String get avatarBg => "$_path/avatar_bg.jpeg";
}

class AppIcons {
  const AppIcons();

  final String _path = "assets/icons";

  String get user => "$_path/user.svg";
  String get settings => "$_path/setting.svg";
  String get search => "$_path/search.svg";
  String get favorites => "$_path/favorites.svg";
  String get share => "$_path/share.svg";
  String get ai => "$_path/ai.svg";
}
