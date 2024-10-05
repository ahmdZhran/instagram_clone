class AuthUserEntity {
  final String id;
  final String username;
  final String email;
  final String name;
  final String bio;
  final String profileImageUrl;

  AuthUserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
  });
}
