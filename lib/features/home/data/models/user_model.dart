import 'package:instai/features/home/domain/entity/user_enttiy.dart';

class UserModel {
  const UserModel({required this.username, required this.createdAt});

  final String username;
  final String createdAt;

  UserEnttiy toEntity() {
    return UserEnttiy(username: username, postCount: 0, avatarPath: null);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"] as String,
      createdAt: json["createdAt"] as String,
    );
  }
}
