class SearchUserEntity {
  final String username;
  final String profileImage;
  final String? uid;

  SearchUserEntity({
    required this.username,
    required this.profileImage,
    this.uid,
  });

  factory SearchUserEntity.fromFirestore(Map<String, dynamic> data) {
    return SearchUserEntity(
      username: data['user_name'] ?? '',
      profileImage: data['profile_image'] ?? '',
      uid: data['uid'] ?? '',
    );
  }
}
