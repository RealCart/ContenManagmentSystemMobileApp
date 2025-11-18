class UserEnttiy {
  const UserEnttiy({
    required this.username,
    required this.postCount,
    required this.avatarPath,
  });

  final String username;
  final String? avatarPath;
  final int postCount;
}
