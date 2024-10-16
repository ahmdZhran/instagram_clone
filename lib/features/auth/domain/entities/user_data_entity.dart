import 'dart:typed_data';

class UserDataEntity {
  final String uid;
  final String email;
  final String password;
  final String userName;
  final String name;
  final String bio;
  final Uint8List? profileImage;

  UserDataEntity({
    required this.uid,
    required this.email,
    required this.password,
    required this.userName,
    required this.name,
    required this.bio,
    required this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'user_name': userName,
      'bio': bio,
      'profile_image': profileImage,
    };
  }

  factory UserDataEntity.fromJson(Map<String, dynamic> json) {
    return UserDataEntity(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      userName: json['user_name'],
      name: json['name'],
      bio: json['bio'],
      profileImage: json['profileImage'],
    );
  }
}
