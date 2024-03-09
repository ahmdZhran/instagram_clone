class UserModel {
  final String id;
  final String email;
  final String username;
  final String name;
  final String bio;
  final List<String> following;
  final List<String> followers;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.bio,
    required this.following,
    required this.followers,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      following: List<String>.from(map['following'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
    );
  }
}
