class UserEntity {
  final String username;
  final String profileImage;

  UserEntity({
    required this.username,
    required this.profileImage,
  });

  factory UserEntity.fromFirestore(Map<String, dynamic> data) {
    return UserEntity(
      username: data['user_name'] ?? '',
      profileImage: data['profile_image'] ?? '',
    );
  }
}
