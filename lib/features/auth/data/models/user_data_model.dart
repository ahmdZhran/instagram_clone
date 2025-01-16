class UserDataModel {
  final String uid;
  final String email;
  final String? password;
  final String? username;
  final String? name;
  final String? bio;
  final String? profileImage;
  final List<String> following;
  final List<String> followers;

  UserDataModel({
    required this.uid,
    required this.email,
    this.password,
    this.username,
    this.name,
    this.bio,
    this.profileImage,
    this.following = const [],
    this.followers = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'user_name': username,
      'bio': bio,
      'profile_image': profileImage,
      'following': following,
      'followers': followers,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      username: json['user_name'],
      name: json['name'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      following: List<String>.from(json['following'] ?? []),
      followers: List<String>.from(json['followers'] ?? []),
    );
  }
}
