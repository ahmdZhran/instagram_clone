class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String bio;
  final List<String> following;
  final List<String> followers;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.following,
    required this.followers,
  });

  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      id: id,
      email: data['email'] ?? '',
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      bio: data['bio'] ?? '',
      following: List<String>.from(data['following'] ?? []),
      followers: List<String>.from(data['followers'] ?? []),
    );
  }
}
