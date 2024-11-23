class UserPostsProfileEntity {
  final String uid;
  final List<String> userPostsProfile;

  UserPostsProfileEntity({
    required this.uid,
    required this.userPostsProfile,
  });

  factory UserPostsProfileEntity.fromJson(Map<String, dynamic> json) {
    return UserPostsProfileEntity(
      uid: json['uid'],
      userPostsProfile: json['user_profile_image'],
    );
  }
}
