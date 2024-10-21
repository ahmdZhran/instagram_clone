class UserProfileEntity {
  final String uid;
  final String name;
  final String username;
  final String bio;
  final String profileImageUrl;

  UserProfileEntity({
    required this.name,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
  });
}
