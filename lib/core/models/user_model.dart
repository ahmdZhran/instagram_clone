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

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      username: data['first_name'] ?? '',
      name: data['last_name'] ?? '',
      bio: data['bio'] ?? '',
      following: List<String>.from(data['following'] ?? []),
      followers: List<String>.from(data['followers'] ?? []),
    );
  }
}
