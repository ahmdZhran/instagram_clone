class UserEntity {
  final String username;
  final String profileImage;
  final String? uid;

  UserEntity({
    required this.username,
    required this.profileImage,
    this.uid,
  });

  factory UserEntity.fromFirestore(Map<String, dynamic> data) {
    return UserEntity(
      username: data['user_name'] ?? '',
      profileImage: data['profile_image'] ?? '',
      uid: data['uid'] ?? '',
    );
  }
}
