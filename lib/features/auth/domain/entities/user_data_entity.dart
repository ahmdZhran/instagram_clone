class UserDataEntity {
  final String uid;
  final String email;
  final String? password;
  final String? username;
  final String? name;
  final String? bio;
  final String? profileImage;

  UserDataEntity({
    required this.uid,
    required this.email,
    this.password,
    this.username,
    this.name,
    this.bio,
    this.profileImage,
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
    };
  }

  factory UserDataEntity.fromJson(Map<String, dynamic> json) {
    return UserDataEntity(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      username: json['user_name'],
      name: json['name'],
      bio: json['bio'],
      profileImage: json['profileImage'],
    );
  }
}
